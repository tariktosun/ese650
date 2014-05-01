% gatherHopperData.m
close all
params = generateParams();
global HOPPER

if isempty(HOPPER),
  hopperInit;
end
%%
gains0 = [0.15, 30, 0.1];   % control gains
N = 500;
dt = 0.01;
Nep = 10;
episodes = {};
for i=1:Nep
    a0 = 2*pi/20*randn(1);
    gains = gains0+randn(1,3)*0.2;
    qstates = runHopper(a0, gains, N, dt, true);
    %episodes{i} = extractQStates(states);
    episodes{i} = [ qstates, repmat(gains, size(qstates,1), 1) ];
    disp([int2str(i) ': ' int2str(size(episodes{i},1)) ' states']);
end
%%
% mean-center and scale the data.
e = cat(1, episodes{:});
m = mean( e(:,2:end) );          % first column is success indicator
stddev = std( e(:,2:end) );
scaledEpisodes = episodes;
for i=1:numel(episodes)
    centered = bsxfun(@minus, episodes{i}(:,2:end), m);
    scaled = bsxfun(@rdivide, centered, stddev);
    scaledEpisodes{i} = [episodes{i}(:,1) scaled];
end
%% Generate Q-learning centers with Kmeans
[ centers, Qvals ] = initQ( scaledEpisodes, params.numCenters, N );