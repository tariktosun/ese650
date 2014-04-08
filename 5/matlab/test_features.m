classdef test_features < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        map
        bigmap
    end
    
    methods (TestMethodSetup)
        function setup(testCase)
            params = create_params();
            testCase.bigmap = imread('aerial_color.jpg');
            testCase.map = imresize(testCase.bigmap, params.resize_factor);
        end
    end
    
    methods (Test)
        function test_kmeans_gauss(testCase)
            params = create_params();
            %% Gaussian blur:
            %# Create the gaussian filter with hsize = [5 5] and sigma = 2
            G = fspecial('gaussian',[5 5],2);
            %# Filter it
            sharp_map = testCase.map;
            map = imfilter(testCase.map,G,'same');
            %# Display
            %imshow(map)
            %% Extract 10 colors using kmeans
            nColors = 10;
            [nrows,ncols,~] = size( map );
            map_list = double(reshape( map, nrows*ncols, 3 ));
            [cluster_idx, cluster_center] = kmeans( map_list ,nColors); %,'distance', 'sqEuclidean', 'Replicates',3);
            %%
            pixel_labels = reshape(cluster_idx,nrows,ncols);
            colormap = varycolor(10);
            figure;
            imshow(pixel_labels, colormap), title('image labeled by cluster index');
        end
        %% edge detection
        function test_edge_detection(testCase)
            bwmap = rgb2gray(testCase.map);
            BW1 = edge(bwmap,'sobel');
            BW2 = edge(bwmap,'canny');
            figure, imshow(BW1)
            figure, imshow(BW2)
            %% Gaussian blur
            G = fspecial('gaussian',[2 2],2);
            blurred = imfilter(BW2,G,'same');
            figure, imshow(blurred)
        end
        %% test extract_features and generate_cost_map
        function test_cost_map(testCase)
            feature_map = extract_features( testCase.map, [] );
            testCase.assertTrue( all(all( (sum( feature_map,3 )-1)<0.0001 )) )
            model.weights = ones(1, size(feature_map,3));
            cost_map = generate_cost_map( feature_map, model, [] );
            testCase.assertTrue( all(all( cost_map == sum(feature_map,3) )) );
        end
        %% function test plan_path:
        function test_plan_path(testCase)
            feature_map = extract_features( testCase.map, [] );
            %testCase.assertTrue( all(all( (sum( feature_map,3 )-1)<0.0001 )) )
            model.weights = ones(1, size(feature_map,3));
            cost_map = generate_cost_map( feature_map, model, [] );
            %testCase.assertTrue( all(all( cost_map == sum(feature_map,3) )) );
            start = [50, 50];
            goal = [200, 1000];
            path = plan_path( cost_map, start, goal, [] );
        end
        %% test indexed image:
        function test_indexed(testCase)
            [ind, cmap] = rgb2ind(testCase.map,32);
            figure();
            imagesc(ind);
            
        end
    end
    
end

