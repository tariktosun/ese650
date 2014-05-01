function r = reward( s, params )
% r = reward( state, gamma )
% Reward function for Q-learning
%
r = s(1)*(1 - params.lambda*(s(:,2).^2 + s(:,3).^2 + s(:,4).^2 + s(:,5).^2));