function deltaQs = Qupdate( Xt, Xtp1, beta, centers, Qvals, params )
% Qdelta = Qupdate( St, Stp1, centers, Qvals )
% Computes Q-function update.
%
gamma = params.gamma;
Stp1 = Xtp1(1:7); % just the states
rtp1 = reward( Stp1, params );
ks = gaussianKernel( Xt(2:end), centers, params );
alphas = beta*ks;
m = maxAction( Stp1(2:7), centers, Qvals );
One = ones(size(alphas));
deltaQs = -alphas.*Qvals + alphas.*( rtp1*One + gamma*m*One - ks'*Qvals );
