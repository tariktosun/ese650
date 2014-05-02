% mean-center and scale the data.
e = cat(1, episodes{:});
m = mean( e );          % first column is success indicator
stddev = std( e );
scaledEpisodes = episodes;
for i=1:numel(episodes)
    centered = bsxfun(@minus, episodes{i}, m);
    scaled = bsxfun(@rdivide, centered, stddev);
    scaledEpisodes{i} = scaled;
end
%% Generate Q-learning centers with Kmeans
[ centers, Qvals ] = initQ( scaledEpisodes, params.numCenters, N );