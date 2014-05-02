function params = generateParams()
params.gamma = 0.9;    % reward discount
params.lambda = 0.05;  % reward shaping
params.sigma = 5;      % stddev for gaussians
params.thresh = 3*params.sigma;     % closeness threshold for maxAction.
params.beta0 = 0.01;     % Initial Q-learning rate
params.numCenters = 200;
