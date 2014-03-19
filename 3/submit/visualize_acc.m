function visualize_acc(imu_data, pltopts)
% Plots the raw IMU data.
%% arg check
if nargin < 2
    pltopts = '';
end
%%
% if size(imu_data,2) == 10
    t = imu_data(:,1);
    ax = imu_data(:,2:4);
% else
%     ax = imu_data;
%     t = 1:size(imu_data,1);
% end
labels = {'x', 'y', 'z'};
for i=1:3
    subplot(3,1,i);
    plot(t,ax(:,i), pltopts);
    xlabel(labels{i});
    hold on;
end

end