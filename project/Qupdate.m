function deltaQs = Qupdate( Xt, Xtp1, beta, centers, Qvals, params )
% Qdelta = Qupdate( St, Stp1, centers, Qvals )
% Computes Q-function update.
%
gamma = params.gamma;
Stp1 = Xtp1(1:6); % just the states
rtp1 = reward( Stp1, params );
ks = gaussianKernel( Xt, centers, params )';
alphas = beta*ks;
[Qmax, ~] = maxAction( Stp1, centers, Qvals, params );
One = ones(size(alphas));
try
deltaQs = -alphas.*Qvals + alphas.*( rtp1*One + gamma*Qmax*One - ks'*Qvals );
catch
    problem=true;
end
