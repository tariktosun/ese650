function [yhat, scores] = gestureModelClassify(X, hmmModel)
% [yhat, logProbs] = gestureModelClassify(X, hmmModel);
%% test against each model:
N = numel(X);
M = numel(hmmModel);
scores = zeros(N,M);
for i=1:M
    for j=1:N
    % encode X as symbols:
    % only use the accelerations.
    symbols = kmQuantize(X{j}(:,2:4), hmmModel{i}.centers);
    % compute log probability score with this HMM:
    [~,Lp] = hmmdecode(symbols',hmmModel{i}.A,hmmModel{i}.b);
    scores(j,i) = Lp;
    end
end
[~,yhat] = min(scores, [], 2);

end