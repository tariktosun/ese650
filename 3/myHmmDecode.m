function [stateEstimate, sequenceLogProb, logAlpha, logBeta] = myHmmDecode( seq, A, b )
% [stateEstimate, sequenceLogProb, logAlpha, logBeta] = myHmmDecode( seq, A, b )
% Forward-backward algorithm for HMM's.  Works in the log space to avoid
% underflow.
numObs = numel(seq);
numStates = size(A,1);
%% initialize:
logAlpha = ones(numObs, numStates)*-Inf;
logBeta = ones(numObs, numStates)*-Inf;
logAlpha(1,1) = 0;     %We definitely start in the first state
logBeta(end, :) = zeros(1,numStates);   %log(1) = 0
%% forward:
for i=1:numObs
    a = bsxfun( @plus, log( A' ), logAlpha(i-1,:) )';   % a is matrix; prev state down cols, cur state across rows
    Q = max(a, 1);  % Q is a row vector
    logAlpha(i,:) = log( b(:,seq(i))' ) + Q + log( sum( exp(bsxfun(@minus,a,Q)), 1 ) );
end
%% backward:
for i=numObs:1
    a = bsxfun(@plus, log( b(:, seq(i+1))' ), ...
            bsxfun(@plus, log( A ), logBeta(i+1,:) ) );
    Q = max(a, [], 2);  % Q is a column vector
    logBeta(i,:) = ( Q + log( sum( exp(bsxfun(@minus,a,Q)), 2) ) )';
end
%% compute stateEstimate and sequenceLogProb:
% compute stateEstimate:
logGamma = logAlpha + logBeta;
[~, stateEstimate] = max(logGamma, [], 2);
% compute log prob of entire sequence:
a = logAlpha(logAlpha(end,:));
Q = max(a);
sequenceLogProb = Q + log( sum( exp(a-Q) ) );

end