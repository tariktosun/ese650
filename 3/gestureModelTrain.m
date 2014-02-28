function [ hmmModel ] = gestureModelTrain( X, y, params )
% [ hmmModel ] = gestureModelTrain( X, y )
% Trains several HMM models to recognize different gestures.
% Assumes data has been quantized already.

%% Perform KNN to generate codebooks:
k = params.k;
[ X, centers ] = kmClusterData( X, y, k );

%% HMM setup:
numHidden = params.numHidden;
pTrans = 0.1;
Ai = eye(numHidden)*(1-pTrans) + diag( ones(numHidden-1, 1), 1 )*pTrans;
Ai(numHidden, 1) = pTrans;
bi = ones(numHidden, k)/numHidden;
%% Train HMM's:
hmmModel = {};
symbols = unique(y);
assert(all( symbols' == 1:max(symbols) ));   % should be integers.
for i=1:max(symbols)
    hmmModel{i} = struct();
    seq = X( y==i );
    [A, b] = hmmtrain( seq, Ai, bi, 'Verbose', true);
    hmmModel{i}.A = A;
    hmmModel{i}.b = b;
    hmmModel{i}.centers = centers{i};
end