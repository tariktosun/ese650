function cost_map = generate_cost_map( feature_map, model, params )
    w = model.weights;
    w = reshape( w, [1,1,numel(w)] );
    cost_map = exp( sum( bsxfun( @times, feature_map, w ), 3 ) );