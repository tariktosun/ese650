function [ propagated ] = motion_model( particle, data, dt, params )
% [ propagated ] = motion_model( particle, data, params );
% 
%% add sensor noise:
data = add_sensor_noise( data, params );
%% propagate state forward using encoder and gyro data:
integrated = step_odometry( particle, data, dt, params );
%% add noise:
propagated = integrated;
%propagated = add_motion_noise( integrated, params );