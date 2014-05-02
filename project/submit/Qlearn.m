function [Qvals, QvalsHistory] = Qlearn( episodes, Qdata )% centers, Qvals, params )
% Qvals = Qlearn( episodes, centers, Qvals )
% Batch learn Q-function for episodes.
%
centers = Qdata.centers;
Qvals = Qdata.Qvals;
params = Qdata.params;
numRepetitions = 3;
QvalsHistory = repmat(Qvals, 1, numRepetitions);
Nep = numel(episodes);
for r = 1:numRepetitions
    disp(['Round ' int2str(r)]);
    beta = params.beta0*exp(-(4*(r-1)))
    %beta = params.beta0;
    deltaQ = zeros(size(Qvals));
    parfor i=1:Nep
        X = episodes{i};   % states and actions
        Nsteps = size(X,1);
        for t=1:Nsteps-1
            deltaQ = deltaQ + Qupdate( X(t,:), X(t+1,:), beta, Qdata );% centers, Qvals, params );
        end
    end
    Qvals = Qvals + deltaQ;
    QvalsHistory(:,r) = Qvals;
end