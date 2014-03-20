function [ output, slam_state ] = step_slam( data, p_slam_state, p_output, params )
%[ output, slam_state ] = step_slam( data, p_slam_state, p_output )
%
%% initialization


%% (1) a priori estimate for particles using odometry
a_priori_particles = a_priori( p_particles, data.odometry, params );

%% (2) a posteriori estimate for particles and map using scan matching
[a_posteriori_particles, a_posteriori_map] = ...
    a_posteriori( a_priori_particles, p_output.map, params );

%% (3) re-sample particles
resamples_particles = resample( a_posteriori_particles );

%% Package output and return.
output.map = a_posteriori_map;
output.particles = resamples_particles;