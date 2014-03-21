function [ Y ] = transform_range( particle, ranges, angles )
% [ Y ] = transform_range( particle, ranges, angles )
% Computes transform from Hokuyo to world frame.
%% Compute transform:
zwheel = 0.254/2;
Tsensor2imu = trans( [-0.29833+0.3302/2, 0, -0.51435] );
Timu2world = trans( particle(1), particle(2), zwheel )*...
    rotz(particle(3))*roty(0)*rotx(0);
T = Timu2world*Tsensor2imu;
%% Apply transform to ranges:
%xy position in the sensor frame
xs0 = (ranges.*cos(angles))';
ys0 = (ranges.*sin(angles))';

%convert to body frame using initial transformation
X = [xs0;ys0;zeros(size(xs0)); ones(size(xs0))];
Y=T*X;

%transformed xs and ys
%xs1 = Y(1,:);
%ys1 = Y(2,:);