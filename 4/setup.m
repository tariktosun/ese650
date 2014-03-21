addpath(genpath('data'));
% load data:
load Encoders20.mat
load Hokuyo20.mat
imu = load('imuRaw20.mat')

raw_data = struct();
raw_data.Hokuyo = Hokuyo0;
raw_data.Encoders = Encoders;
raw_data.imu = imu;

data = clean_data( raw_data );