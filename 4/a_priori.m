function [ a_priori_particles ] = a_priori( p_particles, odometry_data, params )
% [ a_priori_particles ] = a_priori( p_particles, odometry_data, params )
% Propagates particles forward using odometry.
% p_particles: 3xP
%% initialization

%% Propagate each particle.
for i=1:num_particles
    [ propagated ] = motion_model( p_particles{i}, odometry_data, dt, params );
    a_priori_particles = cat(2, a_priori_particles, propagated);
end