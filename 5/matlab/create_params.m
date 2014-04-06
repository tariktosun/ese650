function params = create_params()
params = struct();
%% Map
% image resize factor:
params.resize_factor = 0.1;
%% Gradient ascent:
params.step_size = 0.1;
params.max_iter = 100;
params.convergence_thresh = 0.001;
%% plotting:
params.plot_on = true;