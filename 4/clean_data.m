function [ data ] = clean_data( raw_data )
% [ data ] = clean_data( raw_data )
% Processes raw data to sync times, making it appropriate for use in SLAM.
% Assumes raw data has fields: Hokuyo, Encoders, imu.
%% Synchronize data to the Hokuyo times.
hts = raw_data.Hokuyo.ts;   % times
ets = raw_data.Encoders.ts;
its = raw_data.imu.ts;
hts = hts(hts < its(end));
eidx = zeros(size(hts));    % indices
iidx = zeros(size(hts));
% Extract appropriate indices:
for i=1:numel(hts)
    eidx(i) = find( ets >= hts(i), 1, 'first' );
    iidx(i) = find( its >= hts(i), 1, 'first' );
end

%% Package data
data = struct();
data.ts = hts;
data.ranges = raw_data.Hokuyo.ranges;
data.angles = raw_data.Hokuyo.angles;
data.Encoders = raw_data.Encoders.counts(:, eidx);
% Process IMU data:
wz = raw_data.imu.vals(4, :);
wx = raw_data.imu.vals(5, :);
wy = raw_data.imu.vals(6, :);
omega = [wx; wy; wz];
omega_bias = [373.56; 375.46; 369.60];
omega_scale = 0.0171;
omega = bsxfun(@minus, omega, omega_bias)*omega_scale;
data.gyro = omega(:, iidx);
%% Process and return
% average encoder values:
data.Encoders(1,:) = (data.Encoders(1,:)+data.Encoders(3,:))/2;
data.Encoders(2,:) = (data.Encoders(2,:)+data.Encoders(4,:))/2;
data.Encoders = data.Encoders(1:2,:);


% find and zero encoder and gyro duplicates:
%data.Encoders(:,eidx==[0 eidx(1:end-1)]) = 0;
%data.imu(:, iidx==[0 iidx(1:end-1)]) = 0;
