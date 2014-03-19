function [ hmmModel, centers ] = gestureModelTrain( X, y, params )
% [ hmmModel ] = gestureModelTrain( X, y )
% Trains several HMM models to recognize different gestures.

%% Perform KNN to generate codebook:
k = params.k;
[ centers ] = kmSingleCodebook( X, k );
% quantize X:
for i=1:numel(X)
    X{i} = kmQuantize(X{i}, centers)';
end
%% HMM setup:
numHidden = params.numHidden;
pTrans = 0.1;
Ai = eye(numHidden)*(1-pTrans) + diag( ones(numHidden-1, 1), 1 )*pTrans;
Ai(numHidden, 1) = pTrans;
bi = ones(numHidden, k)/numHidden;
%% Train HMM's:
hmmModel = {};
symbols = unique(y);
%assert(all( symbols' == 1:max(symbols) ));   % should be integers.
%for i=1:max(symbols)
for i=params.labels
    hmmModel{i} = struct();
    seq = X( y==i );
    %[A, b] = hmmtrain( seq, Ai, bi, 'Verbose', true);
    [A, b] = myHmmTrain( seq, Ai, bi);
    hmmModel{i}.A = A;
    hmmModel{i}.b = b;
end