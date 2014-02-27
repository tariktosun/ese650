%% Convert quantized data to vector form

dataset = lpf;
X = {};
y = [];
for i=1:numel(names)
    X = cat(2, X, dataset.(names{i}));
    y = cat(1, y, ones(numel(dataset.(names{i})), 1)*i);
end
N = numel(y);
%% test gestureModelTrain.m
params = struct();
params.k = 3;
params.numHidden = 6;
[ hmmModel ] = gestureModelTrain( X, y, params );

%% partition:
num_partitions = 3;
cp = cvpartition(y, 'k', num_partitions);

correct = [];
for i=1:cp.NumTestSets
    test_idx = test(cp,i);
    hmmModel = gestureModelTrain(X{~test_idx}, y(~test_idx), params);
    [yhat, logProbs] = gestureModelClassify(X{test_idx}, hmmModel);
    correct = cat( 1, correct, yhat==y(test_idx) ); 
end
% compute and return error rate:
error_rate = sum( ~correct ) / numel(correct);