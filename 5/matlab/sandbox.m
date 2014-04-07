A = feature_map;
i1 = [1,3,5]';
i2 = [1,3,5]';
%i3 = repmat([1:5], numel(i1), 1);
i3 = [1:5]
%i1 + (i2-1)*size(A,1) + (i3-1)*size(A,1)*size(A,2)
idx = bsxfun(@plus, i1, bsxfun(@plus, (i2-1)*size(A,1), (i3-1)*size(A,1)*size(A,2)) )

