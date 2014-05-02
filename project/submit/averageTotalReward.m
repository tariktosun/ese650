function Ravg= averageTotalReward( episodes, Qdata )
% R = averageTotalReward( episodes )
% Returns the average total reward for this set of episodes.
N = numel(episodes);
qstates = cat(1, episodes{:});
R = reward( qstates(:,1:6), Qdata.params );
Ravg = sum(R)/N;