function [cost_map, model] = train_model( feature_map, model, example_paths, params )
% [cost_map, model] = train_model( feature_map, model, example_paths, params )
% Trains model using gradient descent
%
%%
w = model.weights;  % initial model
N = numel(example_paths);
%%

if params.plot_on
    figure;
end
for j=1:params.max_iter
    % Generate cost map:
    cost_map = generate_cost_map( feature_map, model, params );
    G = zeros(size(w))';
    for i=1:N
        % plan a path for an example:
        des = example_paths{i};
        start = des(1,:);
        goal = des(end,:);
        [opt, ctg] = plan_path( cost_map, start, goal, [] );
        if params.plot_on
            %figure
            title(['Example ' int2str(i)]);
            plot_path( opt, start, goal, cost_map, ctg, 'b' );
            hold on
            plot_path( des, start, goal, [], [], 'r');
            hold off
            drawnow
        end
        % compute gradient:
        g = compute_gradient( feature_map, cost_map, des, opt );
        G = G + g;
    end
    % check termination:
    norm(G)
    if norm(G) < params.convergence_thresh
        break
    end
    % take a step:
    w = w - params.step_size * (G'+2*w);
    model.weights = w;
end
%% return