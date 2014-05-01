function params = generateParams()
params.gamma = 0.9;    % reward discount
params.lambda = 0.05;  % reward shaping
params.thresh = 1;     % closeness threshold for maxAction.
params.sigma = 1;      % stddev for gaussians
params.beta0 = 10;     % Q-learning rate
params.numCenters = 100;
