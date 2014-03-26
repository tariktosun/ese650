function noised_particle = add_motion_noise( particle, params )
%
% Add noise to the particle.
sigmas = [params.sigmaXY params.sigmaXY params.sigmaTheta]';
noised_particle = particle + bsxfun(@times, sigmas, randn(size(particle)));