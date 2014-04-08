classdef test_train < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        map
        bigmap
        feature_map
        cost_map
        model
        examples
    end
    
    methods (TestMethodSetup)
        function setup(testCase)
            params = create_params();
            %{
            bigmap = imread('aerial_color.jpg');
            map = imresize(bigmap, params.resize_factor);
            feature_map = extract_features( map, params );
            %}
            load map.mat;
            %
            testCase.feature_map = feature_map;
            testCase.bigmap = bigmap;
            testCase.map = map;
            %
            model.weights = ones(1, size(feature_map,3));
            cost_map = generate_cost_map( feature_map, model, [] );
            testCase.model = model;
            testCase.cost_map = cost_map;
            %
            load examples.mat
            testCase.examples = examples;
        end
    end
    
    methods (Test)
        %% Test planner
        function test_dijkstra_basic(testCase)
            start = [100, 300];
            goal = [250, 800];
            [path, ctg] = plan_path( testCase.cost_map, start, goal, [] );
            plot_path( path, start, goal, testCase.cost_map, ctg );
        end
        %% test train_model.m
        function test_train_model_basic(testCase)
            params = create_params();
            [cost_map, model] = train_model( testCase.feature_map, testCase.model, testCase.examples,  params);
        end
        %% test easy map:
        function test_easy_map(testCase)
            params = create_params();
            params.num_clusters = 2;
            params.resize_factor = 1;
            load easy_map
            load easy_examples
            model.weights = ones(1, size(feature_map,3));
            [cost_map, model] = train_model( feature_map, model, examples,  params);
            % Check that it generalizes:
            %start = [435, 227];   goal = [375, 321];
            start = [201, 505];   goal = [73, 386];
            [path, ctg] = plan_path( cost_map, start, goal, [] );
            figure;
            plot_path( path, start, goal, cost_map, ctg, 'b' );
            hold on;
            title('Generalized');
            hold off;
        end
    end
    
end