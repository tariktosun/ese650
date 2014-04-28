extractHopperStates
%
kick_on = footPosition(3,:) < kick_thresh;

figure;
subplot(8,1,1);
plot(t, topPosition(3,:));
hold on; title('Top z'); hold off;
subplot(8,1,2);
plot(t, topLinearVelocity(3,:), 'r');
hold on; title('Top zdot'); hold off;
%
subplot(8,1,3);
plot(t, legPosition(3,:));
hold on; title('Leg z'); hold off;
subplot(8,1,4);
plot(t, legLinearVelocity(3,:), 'r');
hold on; title('Leg zdot'); hold off;
%
subplot(8,1,5);
plot(t, anklePosition);
hold on; title('Ankle Position'); hold off;
subplot(8,1,6);
plot(t, anklePositionRate, 'r');
hold on; title('Ankle Position Rate'); hold off;
%
subplot(8,1,7);
plot(t, footPosition(3,:));
hold on; title('Foot z'); hold off;
% 
subplot(8,1,8);
plot(t, kick_on);
hold on; title('kick on'); hold off;