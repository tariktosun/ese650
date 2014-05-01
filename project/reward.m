function r = reward( s, params )
% r = reward( state, gamma )
% Reward function for Q-learning
%
r = ones(size(s,1)) - params.lambda*( s(:,1:4)*s(:,1:4)' );