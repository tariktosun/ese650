function cost_map = cost_function( feature_map, model, params )
    w = model.weights;
    w = reshape( w, [1,1,numel(w)] );
    cost_map = sum( bsxfun( @times, feature_map, w ), 3 );