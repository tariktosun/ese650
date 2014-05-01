function Qvals = Qlearn( episodes, centers, Qvals, params )
% Qvals = Qlearn( episodes, centers, Qvals )
% Batch learn Q-function for episodes.
%

numRepetitions = 5;
Nep = numel(episodes);
for r = 1:numRepetitions
    beta = params.beta0;%*exp(-r);
    deltaQ = zeros(size(Qvals));
    for i=1:Nep
        X = episodes{i};   % states and actions
        Nsteps = numel(X);
        for t=1:Nsteps-1
            deltaQ = deltaQ + Qupdate( X(t,:), X(t+1,:), beta, centers, Qvals, params );
        end
    end
    Qvals = Qvals + deltaQ;
end