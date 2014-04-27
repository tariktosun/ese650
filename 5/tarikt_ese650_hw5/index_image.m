function [ idx ] = index_image( rows, cols, i3, A )
% [ idx ] = index_image( i1, i2, i3, A )
% Returns indices to pull vectors from image A.  rows and cols are vectors of
% row and column indices. They must contain the same number of elements N.
% i3 is a vector of indices corresponding to slices in the third dimension,
% and is M long. The returned matrix idx is NxM.

S = size(A);
rows = reshape(rows, numel(rows),1);
cols = reshape(cols, numel(cols),1);
i3 = reshape(i3, 1, numel(i3));
idx = bsxfun(@plus, rows, bsxfun(@plus, (cols-1)*S(1), (i3-1)*S(1)*S(2)) );

