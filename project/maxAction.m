function [Q, action] = maxAction( S, centers, Qvals, params )
% [action, Q] = maxAction( S, centers, Qvals, params )
% returns the max Q and argmax action for the given state, centers, and Q
% values.
%
stateCenters = centers(:,1:6);
actionCenters = centers(:,7:end);
%
activeRows = find( sum( bsxfun( @minus, stateCenters, S ).^2, 2 ) < params.thresh^2 );
%assert(numel(activeRows)>0);
if(~(numel(activeRows)>0))
    activeRows = ones(size(stateCenters,1),1);
end
N = numel(activeRows);
testPoints = [ repmat( S, N, 1 ), actionCenters(activeRows, :) ];
Qs = gaussianKernel( testPoints, centers(activeRows, :), params )' * Qvals( activeRows );
[Q, row] = max(Qs);
action = actionCenters(row, :);

