function noised_data = add_sensor_noise( data, params )
%
% Add noise to the particle.
sigmas = [params.sigmaRL params.sigmaRL params.sigmaGyro]';
noised_data = data;
noised_data.Encoders = noised_data.Encoders + params.sigmaRL*randn([2,1]);
noised_data.gyro = noised_data.gyro + params.sigmaGyro*randn([3,1]);