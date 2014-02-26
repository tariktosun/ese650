function visualize_gyro(imu_data, pltopts)
% Plots the raw IMU data.
%% arg check
if nargin < 2
    pltopts = '';
end
%%
t = imu_data(:,1);
gyro = imu_data(:,5:7);
labels = {'x', 'y', 'z'};
for i=1:3
    subplot(3,1,i);
    plot(t-t(1),gyro(:,i), pltopts);
    xlabel(labels{i});
    hold on;
end

end