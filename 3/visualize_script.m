% Visualize script: visualizes raw data.
%% 
name = 'hammer';
motion = train.(char(name));
%% Visualize:
figure;
colors = {'k', 'r', 'b', 'c', 'g'};
for i=1:5
    visualize_acc(motion{i}, colors{i});
end
subplot(3,1,1);
title([name ' accelerations']);
figure;
for i=1:5
    visualize_gyro(motion{i}, colors{i});
end
subplot(3,1,1);
title([name ' gyro']);