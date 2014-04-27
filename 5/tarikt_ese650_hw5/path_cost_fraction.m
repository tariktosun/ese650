function pcf = path_cost_fraction( cost_map, des, opt, params )
% pcd = path_cost_difference( cost_map, des, opt, params )
% Computes path-cost-fraction between desired and optimal paths.
des = floor(des);
opt = floor(opt);
des_idx = index_image( des(:,1), des(:,2), 1, cost_map);
opt_idx = index_image( opt(:,1), opt(:,2), 1, cost_map);
des_cost = sum(cost_map(des_idx));% / numel(des_idx);
opt_cost = sum(cost_map(opt_idx));% / numel(opt_idx);
pcf = des_cost/opt_cost;