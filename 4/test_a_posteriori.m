classdef test_a_posteriori < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        raw_data
        data
        names
    end
    
    methods (TestMethodSetup)
        function setup(testCase)
            addpath(genpath('data'));
            % load data:
            testCase.names = {'20', '21', '22', '23', '24'};
            [ raw_data, data ] = load_data( testCase.names );
            testCase.raw_data = raw_data; testCase.data = data;
        end
    end
    
    methods (Test)
        %%
        function test_transform_range_basic(testCase)
            particle = [1 -1 pi/4]';
            angles = [0, pi/2, -pi/4, -pi/2]';
            ranges = [1,  1,     1,   1]';
            [ Y ] = transform_range( particle, ranges, angles );
            figure; 
            plot3(Y(1,:), Y(2,:), Y(3,:), 'x');
            hold on
            plot3(particle(1), particle(2), 0, 'ko')
            l = 0.25;
            plot3([particle(1) particle(1)+l*cos(particle(3))], ...
                [particle(2) particle(2)+l*sin(particle(3))], [0 0], 'k');
            axis([-2 2 -2 2 -1 1])
            grid on
        end
        %%
        function test_transform_range(testCase)
            particle = [0 0 0]';
            angles = testCase.data{1}.angles;
            ranges = testCase.data{1}.ranges(:,1500);
            [ Y ] = transform_range( particle, ranges, angles );
            figure; 
            plot3(Y(1,:), Y(2,:), Y(3,:), '.');
            hold on
            plot3(particle(1), particle(2), 0, 'ko')
            l = 0.25;
            plot3([particle(1) particle(1)+l*cos(particle(3))], ...
                [particle(2) particle(2)+l*sin(particle(3))], [0 0], 'k');
            %axis([-2 2 -2 2 -1 1])
            grid on
        end
        %% test self-consistency over time:
        function test_self_consistency(testCase)
            D = testCase.data{2};
            Weff = (((476.25 + 311.15)/2) / 1000) * 1.8;
            indices = 500:1000;
            colorset = varycolor(numel(indices));
            x = zeros(3,numel(indices));
            x(:,1) = [0; 0; 0];
            Y = transform_range( x(:,indices(1)), D.ranges(:,indices(1)), D.angles );
            figure
            plot3(Y(1,:), Y(2,:), Y(3,:), '.', 'Color', colorset(1,:));
            hold on
            plot3(x(1,1), x(2,1), 0, 'ko')
            l = 0.25;
            plot3([x(1,1) x(2,1)+l*cos(x(3,1))], ...
                [x(2,1) x(2,1)+l*sin(x(3,1))], [0 0], 'k');
            j = 1;
            for i=indices(2:end)  % Step through time
                j = j+1;
                e = D.Encoders(:,i-1);
                x(:,i) = step_odometry( x(:,i-1), e, Weff );
                [ Y ] = transform_range( x(:,i), D.ranges(:,i), D.angles );
                plot3(Y(1,:), Y(2,:), Y(3,:), '.', 'Color', colorset(j,:));
                plot3(x(1,i), x(2,i), 0, 'ko')
                l = 0.25;
                plot3([x(1,i) x(2,i)+l*cos(x(3,i))], ...
                [x(2,i) x(2,i)+l*sin(x(3,i))], [0 0], 'k');
                %axis([-2 2 -2 2 -1 1])
                grid on
                drawnow
            end
        end
    end
    
end

