function [cost_map, model] = train_model( feature_map, model, example_paths, params )
% [cost_map, model] = train_model( feature_map, model, example_paths, params )
% Trains model using gradient descent
%
%%
w = model.weights;  % initial model
N = numel(example_paths);
%%
for j=1:params.max_iter
    % Generate cost map:
    cost_map = generate_cost_map( feature_map, model, params );
    for i=1:N
        % plan a path for an example:
        des = example_paths{i};
        start = des(1,:);
        goal = des(end,:);
        [opt, ctg] = plan_path( cost_map, start, goal, [] );
        if params.plot_on
            figure
            title(['Example ' int2str(i)]);
            plot_path( opt, start, goal, cost_map, ctg );
            hold on
            plot_path( des, start, goal ,'m');
            hold off
        end
        % compute gradient:
        g = compute_gradient( feature_map, cost_map, des, opt );
        G = G + g;
    end
    % check termination:
    if G < params.convergence_thresh
        break
    end
    % take a step:
    w = w + params.step_size * G;
end
%% return:
model.weights = w;