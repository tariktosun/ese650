classdef test_a_priori < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        raw_data
        data
        names
        basic_encoder
    end
    
    methods (TestMethodSetup)
        function setup(testCase)
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
        function test_step_odometry(testCase)
            Weff = (((476.25 + 311.15)/2) / 1000) * 1.8;
            for j=1:numel(testCase.names)
                D = testCase.data{j};
                x = zeros(3,numel(D.ts));
                x(:,1) = [0; 0; 0];
                for i=2:numel(D.ts)
                    e = D.Encoders(:,i);
                    x(:,i) = step_odometry( x(:,i-1), e, Weff );
                end
                figure()
                plot(x(1,:), x(2,:), '.')
            end
        end
        
        function test_step_odometry_basic(testCase)
            Weff = (((476.25 + 311.15)/2) / 1000) * 1.8;
            N = size(testCase.basic_encoder,2);
            x = zeros(3,N);
            x(:,1) = [0; 0; 0];
            for i=2:N
                e = testCase.basic_encoder(:,i);
                x(:,i) = step_odometry( x(:,i-1), e, Weff );
            end
            figure();
            plot(x(1,:), x(2,:), '.')
            axis equal
            title('basic');
        end
    end
    
end

