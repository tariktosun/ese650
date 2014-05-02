% gatherHopperData.m
close all
params = generateParams();
global HOPPER

if isempty(HOPPER),
  hopperInit;
end
%%
useQ = true;
gains0 = [0.15, 30, 0.1];   % control gains
N = 500;
dt = 0.01;
Nep = 10;
episodes = {};
for i=1:Nep
    a0 = 2*pi/20*randn(1);
    gains = gains0+randn(1,3)*0.2;
    if useQ
        policy = Qdata;
        plotOn = true;
    else
        policy = gains;
        plotOn = false;
    end
    qstates = runHopper(a0, policy, N, dt, useQ, plotOn);
    episodes{i} = [ qstates, repmat(gains, size(qstates,1), 1) ];
    disp([int2str(i) ': ' int2str(size(episodes{i},1)) ' states']);
end
%%
postProcess;