function Qvals = Qlearn( episodes, Qdata )% centers, Qvals, params )
% Qvals = Qlearn( episodes, centers, Qvals )
% Batch learn Q-function for episodes.
%
centers = Qdata.centers;
Qvals = Qdata.Qvals;
params = Qdata.params;
numRepetitions = 5;
Nep = numel(episodes);
for r = 1:numRepetitions
    beta = params.beta0*exp(-r);
    deltaQ = zeros(size(Qvals));
    for i=1:Nep
        X = episodes{i};   % states and actions
        Nsteps = size(X,1);
        for t=1:Nsteps-1
            deltaQ = deltaQ + Qupdate( X(t,:), X(t+1,:), beta, Qdata );% centers, Qvals, params );
        end
    end
    Qvals = Qvals + deltaQ;
end