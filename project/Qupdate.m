function deltaQs = Qupdate( Xt, Xtp1, beta, Qdata); %centers, Qvals, params )
% Qdelta = Qupdate( St, Stp1, centers, Qvals )
% Computes Q-function update.
%
centers = Qdata.centers;
Qvals = Qdata.Qvals;
params = Qdata.params;
%
gamma = params.gamma;
Stp1 = Xtp1(1:6); % just the states
real_Stp1 = (Stp1.*Qdata.stddevs(1:6))+Qdata.means(1:6);  % need to use unscaled values for reward.
rtp1 = reward( real_Stp1, params );
ks = gaussianKernel( Xt, centers, params )';
alphas = beta*ks;
[Qmax, ~] = maxAction( Stp1, centers, Qvals, params );
One = ones(size(alphas));
try
deltaQs = -alphas.*Qvals + alphas.*( rtp1*One + gamma*Qmax*One - ks'*Qvals );
catch
    problem=true;
end
