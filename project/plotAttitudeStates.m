extractHopperStates
kick_on = footPosition(3,:) < kick_thresh;
%% Plot Attitudes:
figure;
rows = 7; cols = 1;
%
subplot(rows,cols,1);
plot(t, bodyRoll);
hold on; title('Body Roll'); hold off;
%
subplot(rows,cols,2);
plot(t, bodyPitch);
hold on; title('Body Pitch'); hold off;
%
subplot(rows,cols,3);
plot(t, hipPitch, 'r');
hold on; title('Hip Pitch'); hold off;
%
subplot(rows,cols,4);
plot(t, hipRoll, 'r');
hold on; title('Hip Roll'); hold off;
%
subplot(rows,cols,5);
plot(t, topLinearVelocity(1,:), 'g');
hold on; title('Body X velocity'); hold off;
%
subplot(rows,cols,6);
plot(t, topLinearVelocity(2,:), 'g');
hold on; title('Body Y Velocity'); hold off;
%
subplot(rows,cols,7);
plot(t, kick_on);
hold on; title('Kick On'); hold off;

