function [ a_priori_particles ] = a_priori( slam_state, data, params )
% [ a_priori_particles ] = a_priori( p_particles, odometry_data, params )
% Propagates particles forward using odometry.
% p_particles: 3xP
%% initialization
particles = slam_state.particles;
num_particles = size(particles,2);
prev_time = slam_state.time;
dt = data.ts - prev_time;
%% Propagate each particle.
a_priori_particles = [];
for i=1:num_particles
    [ propagated ] = motion_model( particles(:,i), data, dt, params );
    a_priori_particles = cat(2, a_priori_particles, propagated);
end