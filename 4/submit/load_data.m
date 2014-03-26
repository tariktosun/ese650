function [ raw_data, data ] = load_data( names )
    raw_data = {};
    data = {};
    for i=1:numel(names)
        load(['Encoders' names{i} '.mat']);
        load(['Hokuyo' names{i} '.mat']);
        imu = load(['imuRaw' names{i} '.mat']);
        raw = struct();
        raw.Hokuyo = Hokuyo0;
        raw.Encoders = Encoders;
        raw.imu = imu;
        raw_data{i} = raw;
        % clean the data:
        data{i} = clean_data( raw );
    end
end