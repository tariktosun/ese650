function [ propagated ] = motion_model( particle, data, params )
% [ propagated ] = motion_model( particle, data, params );
% 
%% propagate state forward using encoder and gyro data:
integrated = step_odometry( particle, data.encoder, data.gyro, dt );

%% add noise:
propagated = add_motion_noise( integrated, params );