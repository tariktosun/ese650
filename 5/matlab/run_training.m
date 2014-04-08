% Train on road:
params = create_params();
load map
load road_examples
model.weights = ones(1, size(feature_map,3));
[cost_map, model] = train_model( feature_map, model, examples,  params);