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

%% Package data and return
data = struct();
data.ts = hts;
data.Hokuyo = raw_data.Hokuyo;
data.Encoders = raw_data.Encoders.counts(:, eidx);
data.imu = raw_data.imu.vals(:, iidx);
