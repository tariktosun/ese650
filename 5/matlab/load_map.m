% script that loads map, pulls features, and saves everything to a .mat
% file.
params = create_params()
bigmap = imread('aerial_color.jpg');
map = imresize(bigmap, params.resize_factor);
feature_map = extract_features( map, params );
save('map.mat', 'bigmap', 'map', 'feature_map');