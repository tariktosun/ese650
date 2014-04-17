params = create_params();
params.num_clusters = 2;
params.resize_factor = 1;
bigmap = imread('easy_map.jpg');
map = imresize(bigmap, params.resize_factor);
feature_map = extract_features( map, params );
save('easy_map.mat', 'bigmap', 'map', 'feature_map');