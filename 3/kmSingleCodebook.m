function [ centers ] = kmSingleCodebook( X, k )
% Returns kmeans centers for the data in X, which is a cell array.
    % Lump all cells into a big matrix:
    x = [];
    for j=1:numel(X)
        x = cat(1, x, X{j});
    end
    % perform kmeans:
    [~, centers] = kmeans(x, k);

end