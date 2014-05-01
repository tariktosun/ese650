% kmeans
foo = cat(1, scaledEpisodes{:});
[idx, centroids, ~, distance_idx] = kmeans( foo, 200, 'emptyaction', 'singleton'); %,'distance', 'sqEuclidean', 'Replicates',3);
%%
figure; plot(centroids(:,1), centroids(:,2), '.');
%%
figure; plot3(centroids(:,7), centroids(:,8), centroids(:,9), '.');