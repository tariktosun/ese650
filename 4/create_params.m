function params = create_params()
%
%
params = struct();
%% map parameters:
params.res   = 0.05; %meters
params.xmin  = -40;  %meters
params.ymin  = -40;
params.xmax  =  40;
params.ymax  =  40;
%dimensions of the map
params.sizex  = ceil((params.xmax - params.xmin) / params.res + 1); %cells
params.sizey  = ceil((params.ymax - params.ymin) / params.res + 1);
%% Odometry:
Weff = (((476.25 + 311.15)/2) / 1000) * 1.8;
params.Weff = Weff;
params.enc_sensitivity = 2*pi/360;%1/120;
params.gyro_weight = 1;
params.gyro_sensitivity=0.0171;
params.gyro_bias = 373.81;
%% Noise Characteristics:
params.sigmaXY = 0.05;        % meters
params.sigmaTheta = 5*pi/180; % radians
end