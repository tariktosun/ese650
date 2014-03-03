function [yhat, scores] = gestureModelClassify(X, hmmModel, centers, labels)
% [yhat, logProbs] = gestureModelClassify(X, hmmModel);
%% test against each model:
N = numel(X);
%M = numel(hmmModel);
M = numel(labels);
scores = zeros(N,M);
for i=1:M       % iterate over label indices
    for j=1:N   % iterate over motions
    % encode X as symbols
    symbols = kmQuantize(X{j}, centers);
    % compute log probability score with this HMM:
    [~,Lp] = hmmdecode(symbols',hmmModel{labels(i)}.A,hmmModel{labels(i)}.b);
    scores(j,i) = Lp;
    end
end
[~,idx] = max(scores, [], 2);
yhat = labels(idx)';

end