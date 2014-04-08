function [cost_map, model] = train_model( feature_map, model, example_paths, params )
% [cost_map, model] = train_model( feature_map, model, example_paths, params )
% Trains model using gradient descent
%
%%
w = model.weights;  % initial model
N = numel(example_paths);
%%
foo = false;
if params.plot_on
    figure;
end
for j=1:params.max_iter
    % Generate cost map:
    cost_map = generate_cost_map( feature_map, model, params );
    G = zeros(size(w))';
    PCF = 0;
    %NUMPTS = 0;
    for i=1:N
        % plan a path for an example:
        des = example_paths{i};
        %augmented_cost_map = augment_cost_map( cost_map, des );
        augmented_cost_map = cost_map;
        start = des(1,:);
        goal = des(end,:);
        [opt, ctg] = plan_path( augmented_cost_map, start, goal, [] );
        if params.plot_on
            %figure
            title(['Example ' int2str(i)]);
            plot_path( opt, start, goal, augmented_cost_map, ctg, 'b.' );
            hold on
            plot_path( des, start, goal, [], [], 'r.');
            hold off
            drawnow
        end
        % compute gradient:
        g = compute_gradient( feature_map, cost_map, des, opt );
        G = G + g;
        pcf = path_cost_fraction( cost_map, des, opt, params );
        numpts = size(des, 1);
        PCF = PCF + pcf;
        %NUMPTS = NUMPTS + numpts;
    end
    % check termination:
    
    if j>1
        avg_pcf = PCF/N
        if avg_pcf < params.convergence_thresh
            break
        end
    end
    
    %if foo == true
    %    break
    %end
    
    
    % take a step:
    %w = w - params.step_size * (G' + params.regularization*w);
    w = w - params.step_size * G';
    model.weights = w;
end
%% return