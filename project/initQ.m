function [ centers, Qvals ] = initQ( scaledEpisodes, numCenters, N )
% [ centers, Qvals ] = initQ( scaledEpisodes, numCenters, N )
% Initializes centers and Q values based on data.
foo = cat(1, scaledEpisodes{:});
[idx, centers, ~, distance_idx] = kmeans( foo, numCenters, 'emptyaction', 'singleton', 'distance', 'sqEuclidean', 'Replicates',3);
Qvals = N/2 + randn(size(centers,1),1)*N/4;  %initialize randomly.