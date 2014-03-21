function [ a_priori_particles ] = a_priori( p_particles, odometry_data, params )
% [ a_priori_particles ] = a_priori( p_particles, odometry_data, params )
% Propagates particles forward using odometry
%% initialization

%% Propagate each particle.
for i=1:num_particles
    [ propagated ] = motion_model( p_particles{i}, odometry_data, params );
    a_priori_particles = cat(1, a_priori_particles, propagated);
end