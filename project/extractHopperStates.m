% Plots state trajectories for the hopper.
% assumes state history is in an array of structs called "state"
%% Extract states
top = [states.top];
topPosition = [top.position];
topLinearVelocity = [top.linearVel];
topRotation = cat(3, top.rotation);
topAngularVelocity = [top.angularVel];
bodyRoll = squeeze(-1.0*asin(topRotation(2,3,:)))';
bodyPitch = squeeze(-atan2(topRotation(1,3,:),topRotation(3,3,:)))';
bodyRollRate = topAngularVelocity(1,:);
bodyPitchRate = topAngularVelocity(2,:);
%
hip = [states.hip];
hipRoll = [hip.angle1];
hipPitch = [hip.angle2];
hipRollRate = [hip.angle1Rate];
hipPitchRate = [hip.angle2Rate];
%
leg = [states.leg];
legPosition = [leg.position];
legLinearVelocity = [leg.linearVel];
legRotation = cat(3, leg.rotation);
legAngularVelocity = [leg.angularVel];
%
ankle = [states.ankle];
anklePosition = [ankle.position];
anklePositionRate = [ankle.positionRate];
%
foot = [states.foot];
footPosition = [foot.position];
t = 0:dt:(N-1)*dt;