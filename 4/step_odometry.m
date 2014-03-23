function [integrated] = step_odometry( particle, encoder, params )
% [integrated] = step_odometry( particle, data.encoder, data.gyro, dt )
% imu, dt, gyro_weight
%%
x = particle(1);
y = particle(2);
theta = particle(3);
eL = encoder(2);
eR = encoder(1);
% scale encoders:
%enc_sensitivity = 0.0125; % rad/mV
wheelRadius = 0.254/2;  % meters
eL = params.enc_sensitivity * eL * wheelRadius;
eR = params.enc_sensitivity * eR * wheelRadius;
%%
% Calculate motion parameters:
dTheta_enc = (eL - eR)/params.Weff;     % THETA SIGN IS WRONG.
%dTheta_gyro = gyro_sensitivity * imu(6) * dt;
%dTheta = dTheta_enc*(1-gyro_weight) + dTheta_gyro*gyro_weight;
dTheta = dTheta_enc;
if dTheta ~= 0 
    radius = eR / dTheta;
    % Approximate curve as turn - straight line - turn. (Thrun):
    dTrans = (radius+params.Weff/2)*dTheta;
else
    dTrans = eR; % eR = eL in this case.
end
    dx = dTrans*cos(theta - dTheta/2);  % THETA SIGN IS WRONG
    dy = dTrans*sin(theta - dTheta/2);  % THETA SIGN IS WRONG
%% Add and return:
integrated = [x+dx; y+dy; theta-dTheta];% THETA SIGN IS WRONG