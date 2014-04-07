function g = compute_gradient( feature_map, cost_map, des, opt )
% g = compute_gradient( feature_map, cost_map, des, opt )
% Computes cost function gradient.
%
%% Discretize paths to pixels:
des = floor(des);
opt = floor(opt);

%% Convert [x y] subscripts to indices:
des_f_ind = index_image( des(:,1), des(:,2), [1:size(feature_map,3)], feature_map ); 
opt_f_ind = index_image( opt(:,1), opt(:,2), [1:size(feature_map,3)], feature_map );
des_c_ind = index_image( des(:,1), des(:,2), 1, cost_map ); 
opt_c_ind = index_image( opt(:,1), opt(:,2), 1, cost_map );
%% Compute gradient:
g = feature_map(des_f_ind')*cost_map(des_c_ind) - feature_map(opt_f_ind')*cost_map(opt_c_ind);
