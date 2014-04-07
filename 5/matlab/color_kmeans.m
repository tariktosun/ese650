function [labels, centroids, distances] = color_kmeans( map, params )
%
% Returns a [ mapRows x mapCols x k ] vector of distances to each kmeans
% centroid.
%
%% Gaussian blur:
%# Create the gaussian filter with hsize = [5 5] and sigma = 2
G = fspecial('gaussian',[5 5],2);
%# Filter it
map = imfilter(map,G,'same');
%% Extract colors using kmeans
nColors = params.num_clusters;
[nrows,ncols,~] = size( map );
map_list = double(reshape( map, nrows*ncols, 3 ));
[idx, centroids, ~, distance_idx] = kmeans( map_list ,nColors); %,'distance', 'sqEuclidean', 'Replicates',3);
%% reshape and return
labels = reshape(idx,nrows,ncols);
distances = reshape(distance_idx, [nrows, ncols, nColors]);
%figure;
%colormap = varycolor(10);
%imshow(pixel_labels, colormap), title('image labeled by cluster index');