function [ slam_state ] = resample_particles( slam_state, params )
% [ resampled_particles ] = resample_particles( particles, a_posteriori_weights, params )
%
weights = slam_state.weights;
particles = slam_state.particles;
NP = numel(weights); % number of particles
Neff = sum(weights)^2 / sum(weights.^2);
if Neff < params.resample_alpha * NP
    idx = resample(weights, NP);
    slam_state.particles = particles(:,idx);
    slam_state.weights = ones(1,NP)/NP;
end