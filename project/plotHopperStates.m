% Plots state trajectories for the hopper.
% assumes state history is in an array of structs called "state"
%% Extract states
top = [states.top];
topPosition = [top.position];
topLinearVelocity = [top.linearVel];
topRotation = cat(3, top.rotation);
topAngularVelocity = [top.angularVel];
bodyRoll = -1.0*asin(topRotation(2,3,:));
bodyPitch = -atan2(topRotation(1,3,:),topRotation(3,3,:));
bodyRollRate = topAngularVelocity(1,:);
bodyPitchRate = topAngularVelocity(2,:);
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
%% Plot z-positions and velocities of all body parts.
plotZstates
%% Plot Attitudes:
figure;
rows = 4; cols = 1;
%
subplot(rows,cols,1);
plot(t, bodyRoll);
hold on; title('Body Roll'); hold off;
%
subplot(rows,cols,2);
plot(t, bodyRollRate, 'r');
hold on; title('Body Roll Rate'); hold off;
%
subplot(rows,cols,3);
plot(t, bodyPitch);
hold on; title('Body Pitch'); hold off;
%
%
subplot(rows,cols,4);
plot(t, bodyRoll, 'r');
hold on; title('Body Pitch Rate'); hold off;
