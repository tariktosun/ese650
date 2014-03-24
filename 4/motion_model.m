function [ propagated ] = motion_model( particle, data, prev_time, params )
% [ propagated ] = motion_model( particle, data, params );
% 
dt = data.ts - prev_time;
%% propagate state forward using encoder and gyro data:
integrated = step_odometry( particle, data.Encoder, imu, dt, params ); % fix this function call
%% add noise:
propagated = add_motion_noise( integrated, params );