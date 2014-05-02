function r = reward( s, params )
% r = reward( state, gamma )
% Reward function for Q-learning
%
r = ones(size(s,1),1) - params.lambda*( sum(s(:,1:4).^2, 2) );