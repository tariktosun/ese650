classdef test_a_priori < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        raw_data
        data
        names
        basic_encoder
        params
    end
    
    methods (TestMethodSetup)
        function setup(testCase)
            Weff = (((476.25 + 311.15)/2) / 1000) * 1.8;
            testCase.params.Weff = Weff;
            testCase.params.enc_sensitivity = 0.0125;
            addpath(genpath('data'));
            % load data:
            testCase.names = {'20', '21', '22', '23', '24'};
            testCase.raw_data = {};
            testCase.data = {};
            for i=1:numel(testCase.names)
                load(['Encoders' testCase.names{i} '.mat']);
                load(['Hokuyo' testCase.names{i} '.mat']);
                imu = load(['imuRaw' testCase.names{i} '.mat']);
                raw_data = struct();
                raw_data.Hokuyo = Hokuyo0;
                raw_data.Encoders = Encoders;
                raw_data.imu = imu;
                testCase.raw_data{i} = raw_data;
                % clean the data:
                testCase.data{i} = clean_data( raw_data );
            end

            % Set up basic encoder test:
            testCase.basic_encoder = 10*[ones(2,10), repmat([1;0],1,10),...
                repmat([0;1],1,10), -ones(2,10), repmat([1;-1],1,10), ones(2,10)];
        end
    end
    
    methods (Test)
        %% Odometry with actual data
        function test_step_odometry(testCase)
            params = testCase.params;
            for j=1:numel(testCase.names)
                D = testCase.data{j};
                x = zeros(3,numel(D.ts));
                x(:,1) = [0; 0; 0];
                for i=2:numel(D.ts)
                    e = D.Encoders(:,i);
                    x(:,i) = step_odometry( x(:,i-1), e, params );
                end
                figure()
                plot(x(1,:), x(2,:), '.')
            end
        end
        %% Basic odometry integrator
        function test_step_odometry_basic(testCase)
            params = testCase.params;
            N = size(testCase.basic_encoder,2);
            x = zeros(3,N);
            x(:,1) = [0; 0; 0];
            figure();
            for i=2:N
                e = testCase.basic_encoder(:,i);
                x(:,i) = step_odometry( x(:,i-1), e, params );
                plot3(x(1,i), x(2,i), 0, 'ko')
                l = 0.25;
                plot3([x(1,i) x(1,i)+l*cos(x(3,i))], ...
                    [x(2,i) x(2,i)+l*sin(x(3,i))], [0 0], 'k');
                plot(x(1,:), x(2,:), '.')
                drawnow;
                hold on
            end
            %plot(x(1,:), x(2,:), '.')
            axis equal
            title('basic');
            hold off
        end
    end
    
end

