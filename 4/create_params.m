function params = create_params(num_particles)
%
%
params = struct();
%% map parameters:
params.res   = 0.1; %meters
params.xmin  = -15;  %meters
params.ymin  = -5;
params.xmax  =  20;
params.ymax  =  25;
%dimensions of the map
params.sizex  = ceil((params.xmax - params.xmin) / params.res + 1); %cells
params.sizey  = ceil((params.ymax - params.ymin) / params.res + 1);
% correlation wiggle:
params.correlation_x_range = -0.5:0.05:0.5;
params.correlation_y_range = -0.5:0.05:0.5;
%% Odometry:
Weff = (((476.25 + 311.15)/2) / 1000) * 1.8;
params.Weff = Weff;
params.enc_sensitivity = 2*pi/360;%1/120;
params.gyro_weight = 1;
params.gyro_sensitivity=0.0171;
params.gyro_bias = 373.81;
%% Hokuyo priors:
logLikCap = 10;
multiplier = 127/logLikCap;
filledPrior = 0.8;  % p(laser-says-filled | actually-filled)
emptyPrior = 0.85;  % p(laser-says-empty | actually-empty)
params.filledIncrement = log(filledPrior/(1-emptyPrior))*multiplier;
params.emptyDecrement = log((1-filledPrior)/emptyPrior)*multiplier;
%% Particles
if nargin < 1
    num_particles = 10;
end
params.NP = num_particles;
%% Noise Characteristics:
if num_particles == 1
    params.sigmaXY = 0;
    params.sigmaTheta = 0;
else
    params.sigmaXY = 0.001;        % meters
    params.sigmaTheta = 0.001;     %radians
end
end