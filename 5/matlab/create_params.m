function params = create_params()
params = struct();
%% Map
% image resize factor:
params.resize_factor = 0.1;
%% Features
params.num_clusters = 16;
%% Gradient ascent:
params.step_size = 0.001;
params.max_iter = 100;
params.convergence_thresh = 1;
params.regularization = 0.1;
%% plotting:
params.plot_on = true;