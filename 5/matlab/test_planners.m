classdef test_planners < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        map
        bigmap
        feature_map
        cost_map
        model
    end
    
    methods (TestMethodSetup)
        function setup(testCase)
            params = create_params();
            testCase.bigmap = imread('aerial_color.jpg');
            testCase.map = imresize(testCase.bigmap, params.resize_factor);
            %
            feature_map = extract_features( testCase.map, [] );
            model.weights = ones(1, size(feature_map,3));
            cost_map = cost_function( feature_map, model, [] );
            testCase.feature_map = feature_map;
            testCase.model = model;
            testCase.cost_map = cost_map;
        end
    end
    
    methods (Test)
        function test_dijkstra_basic(testCase)
            start = [100, 300];
            goal = [250, 800];
            [path, ctg] = plan_path( testCase.cost_map, start, goal, [] );
            plot_path( path, start, goal, testCase.cost_map, ctg );
        end
    end
    
end

