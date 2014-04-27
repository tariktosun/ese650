function feature_map = extract_features( map, params )
% feature_map = extract_features( map, params )
% Generates a feature vector map.
%
[labels, centroids, distances] = color_kmeans( map, params );
distances = exp(-distances); % invert distances
S = sum( distances, 3 );
normalized = bsxfun( @rdivide, distances, S );
feature_map = normalized;