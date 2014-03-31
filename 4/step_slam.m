function [pos, map, slam_state] = step_slam( data, slam_state, map, params )
%
%% (1) a priori estimate for particles using odometry
a_priori_particles = a_priori( slam_state, data, params );
slam_state.particles = a_priori_particles;
%% (2) a posteriori estimate for particles and map using scan matching
[slam_state, a_posteriori_map] = a_posteriori( slam_state, map, data, params );
%% (3) re-sample particles
slam_state = resample_particles( slam_state, params );
%% Package output and return.
map = a_posteriori_map;
slam_state.time = data.ts;
pos = slam_state.particles * slam_state.weights';   % weighted average