function [integrated] = step_odometry( particle, encoder, Weff )
% [integrated] = step_odometry( particle, data.encoder, data.gyro, dt )
%%
x = particle(1);
y = particle(2);
theta = particle(3);
eL = encoder(1);
eR = encoder(2);
% scale encoders:
sensitivity = 0.0125; %rad/mV
eL = sensitivity * eL;
eR = sensitivity * eR;
%%
% Calculate motion parameters:
dTheta = (eL - eR)/Weff;
if dTheta ~= 0 
    radius = eR / dTheta;
    % Approximate curve as turn - straight line - turn. (Thrun):
    dTrans = (radius+Weff/2)*dTheta;
else
    dTrans = eR;
end
    dx = dTrans*cos(theta + dTheta/2);
    dy = dTrans*sin(theta + dTheta/2);
%% Add and return:
integrated = [x+dx; y+dy; theta+dTheta];