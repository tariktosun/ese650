% gatherHopperData.m
close all
params = generateParams();
global HOPPER

if isempty(HOPPER),
  hopperInit;
end
%% Generate a set of gains and a set of IC's
%atr = zeros(1,50);
%for(Iter = 1:50)
useQ = true;
testSet = true;
nIc = 10;
nGains = 10;
gainStd = 0.3;
gains0 = [0.15, 30, 0.1];   % control gains
gainset = abs(bsxfun(@times, gains0, 1+randn(nIc,3)*gainStd));
if(testSet)
    data = load('testIcs.mat');
    ics = data.testIcs;
    nIc = numel(ics);
else
    ics = (pi/5)*randn(nGains,1);
end

if(useQ)
    nGains = 1;
else
    gainset = abs(bsxfun(@times, gains0, 1+randn(nIc,3)*gainStd));
end
%Qdata.Qvals = QvalsHistory(:,1);

%%
N = 500;
dt = 0.01;
Nep = 10;
episodes = cell(1,nGains*nIc);
counter = 0;
for i=1:nIc
    a0 = ics(i);
    for j=1:nGains
        counter = counter + 1;
        if useQ
            policy = Qdata;
            plotOn = true;
        else
            policy = gainset(j,:);
            plotOn = false;
        end
        qstates = runHopper(a0, policy, N, dt, useQ, plotOn);
        episodes{counter} = [ qstates, repmat(gainset(j,:), size(qstates,1), 1) ];
        disp([int2str(i) ', ' int2str(j) ': ' int2str(size(episodes{counter},1)) ' states']);
    end
end
%atr(Iter) = averageTotalReward(episodes, Qdata);
%end
%%
%postProcess;