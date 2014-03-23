classdef test_a_posteriori < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        raw_data
        data
        names
        params
    end
    
    methods (TestMethodSetup)
        function setup(testCase)
            testCase.params = create_params();
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
            params = testCase.params;
            D = testCase.data{2};
            indices = 500:1000;
            colorset = varycolor(numel(indices));
            x = zeros(3,numel(indices));
            x(:,1) = [0; 0; 0];
            Y = transform_range( x(:,1), D.ranges(:,indices(1)), D.angles );
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
                x(:,j) = step_odometry( x(:,j-1), e, params );
                [ Y ] = transform_range( x(:,j), D.ranges(:,i), D.angles );
                plot3(Y(1,:), Y(2,:), Y(3,:), '.', 'Color', colorset(j,:));
                plot3(x(1,j), x(2,j), 0, 'ko')
                l = 0.25;
                plot3([x(1,j) x(1,j)+l*cos(x(3,j))], ...
                [x(2,j) x(2,j)+l*sin(x(3,j))], [0 0], 'k');
                %axis([-2 2 -2 2 -1 1])
                grid on
                drawnow
                pause(0.1);
            end
        end
        %% Basic test of the correlation function
        function test_correlation_basic(testCase)
            params = testCase.params;
            map = create_map( params );
            D = testCase.data{2};
            first = D.ranges(:,100);
            second = D.ranges(:,200);
            % Convert ranges:
            Y1 = transform_range( [0 0 0]', first, D.angles );
            Y2 = transform_range( [0 0 0]', second, D.angles);
            Yi1 = to_cell_indices( Y1, params );
            Yi2 = to_cell_indices( Y2, params );
            % Write first to map:
            x = to_cell_indices([0 0 0]', params );
            write_to_map( map, x, Yi1, int8(ones(1, size(Yi1,2))), params );
            c11 = correlation( map, Y1, params );
            c12 = correlation( map, Y2, params );
            testCase.verifyGreaterThan(c11, c12);
            %Write second to map:
            write_to_map( map, x, Yi2, int8(ones(1, size(Yi1,2))), params );
            c122 = correlation( map, Y2, params );
%            testCase.verifyGreaterThan(c11, c122);
%            testCase.verifyGreaterThan(c122, c12);
        end
    end
    
end

