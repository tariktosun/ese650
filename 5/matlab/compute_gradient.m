function g = compute_gradient( feature_map, cost_map, des, opt )
% g = compute_gradient( feature_map, cost_map, des, opt )
% Computes cost function gradient.
%
%%
[nrows, ncols] = size(cost_map);
%% Scale path lengths:

%% Convert [x y] subscripts to indices:
des_ind = sub2ind( [nrows, ncols], des(:,1), des(:,2) );
opt_ind = sub2ind( [nrows, ncols], opt(:,1), opt(:,2) );
