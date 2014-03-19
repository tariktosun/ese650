function [ quantized ] = kmQuantize( observations, centers )
% [ quantized ] = kmQuantize( observations, centers )
% Quantizes observations into symbols based on the closest center.
%% input processing
assert(size(observations,2) == size(centers,2));
numSym = size(centers,1);
numObs = size(observations,1);
%% find the closest center for each row:
distances = zeros(numObs, numSym);
for i=1:numSym
    c = centers(i,:);
    diff = bsxfun(@minus, observations, c);
    d = sqrt( sum( diff.^2, 2 ) );
    distances(:,i) = d;
end
% find min.
[ ~, quantized ] = min( distances, [], 2 );

end