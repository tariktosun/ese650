function [maxQ, gains] = getGains( state, Q); % centers, Qvals, means, stddevs, params )
% gains = getGains( state, centers, Qvals, means, stddevs, params )
% Returns gains given state and Q-learned parameters.
%% extract and scale the state:
top = state.top;
bodyRoll = -1.0*asin(top.rotation(2,3,:));
bodyPitch = -atan2(top.rotation(1,3,:), top.rotation(3,3,:));
hipRoll = state.hip.angle1;
hipPitch = state.hip.angle2;
qstate = [ top.linearVel(1,:)', top.linearVel(2,:)', bodyRoll', ...
            bodyPitch', hipRoll', hipPitch' ];
scaledState = (qstate - Q.means(1:6))./Q.stddevs(1:6);
%% Get gains:
[maxQ, action] = maxAction( scaledState, Q.centers, Q.Qvals, Q.params );
%% Rescale and return:
gains =  action.*Q.stddevs(7:end) + Q.means(7:end);