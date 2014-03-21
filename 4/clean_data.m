function [ data ] = clean_data( raw_data )
% [ data ] = clean_data( raw_data )
% Processes raw data to sync times, making it appropriate for use in SLAM.
% Assumes raw data has fields: Hokuyo, Encoders, imu.
%% Synchronize data to the Hokuyo times.
hts = raw_data.Hokuyo.ts;   % times
ets = raw_data.Encoders.ts;
its = raw_data.Encoders.ts; 
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
data.imu = raw_data.imu.vals(:, iidx);
%% Process and return
% average encoder values:
data.Encoders(1,:) = (data.Encoders(1,:)+data.Encoders(3,:))/2;
data.Encoders(2,:) = (data.Encoders(2,:)+data.Encoders(4,:))/2;
data.Encoders = data.Encoders(1:2,:);
