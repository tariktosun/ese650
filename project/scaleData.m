function scaledEpisodes = scaleData( episodes, mean, stddev )
% scaled = scaleData( data, mean, stddev )
% mean-centers and scales data.
scaledEpisodes = episodes;
for i=1:numel(episodes)
    centered = bsxfun(@minus, episodes{i}, mean);
    scaled = bsxfun(@rdivide, centered, stddev);
    scaledEpisodes{i} = scaled;
end