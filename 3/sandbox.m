%% Convert data to vector form

dataset = lpf;
X = {};
y = [];
for i=1:numel(names)
    X = cat(2, X, dataset.(names{i}));
    y = cat(1, y, ones(numel(dataset.(names{i})), 1)*i);
end
N = numel(y);
% Select only the appropriate fields:
for i=1:numel(X)
   X{i} = X{i}(:,2:4); 
end
%% test gestureModelTrain.m
% Only use circles and figure8s:
%labels = [1,2];
%labels = [1,2,3,4,5,6];
labels = [2, 5];
mask = zeros(size(y));
for i=labels
    mask = mask | y==i;
end
X = X(mask);
y = y(mask);

params = struct();
params.labels = labels;
params.k = 6;
params.numHidden = 2;
%[ hmmModel ] = gestureModelTrain( X, y, params);

%% partition:
num_partitions = 5;
cp = cvpartition(y, 'k', num_partitions);

correct = [];
for i=1:cp.NumTestSets
    test_idx = test(cp,i);
    hmmModel = gestureModelTrain(X(~test_idx), y(~test_idx), params);
    [yhat, logProbs] = gestureModelClassify(X(test_idx), hmmModel, labels);
    correct = cat( 1, correct, yhat==y(test_idx) ); 
end
% compute and return error rate:
error_rate = sum( ~correct ) / numel(correct)