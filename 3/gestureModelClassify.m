function [yhat, scores] = gestureModelClassify(X, hmmModel, labels)
% [yhat, logProbs] = gestureModelClassify(X, hmmModel);
%% test against each model:
N = numel(X);
%M = numel(hmmModel);
M = numel(labels);
scores = zeros(N,M);
for i=1:M
    for j=1:N
    % encode X as symbols:
    % only use the accelerations.
    symbols = kmQuantize(X{j}, hmmModel{labels(i)}.centers);
    % compute log probability score with this HMM:
    [~,Lp] = hmmdecode(symbols',hmmModel{labels(i)}.A,hmmModel{labels(i)}.b);
    scores(j,i) = Lp;
    end
end
[~,idx] = max(scores, [], 2);
yhat = labels(idx)';

end