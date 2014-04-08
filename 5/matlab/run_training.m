% Train on road:
params = create_params();
params.max_iter = 15;
load map
load pedestrian_examples4
model.weights = ones(1, size(feature_map,3));
[cost_map, model] = train_model( feature_map, model, examples,  params);