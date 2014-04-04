function feature_map = extract_features( map, params )
% feature_map = extract_features( map, params )
% Generates a feature vector map.
%
[labels, centroids, distances] = color_kmeans( map, params );
features_map = distances;