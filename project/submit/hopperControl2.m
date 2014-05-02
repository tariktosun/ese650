function hopperControl(hip1, hip2, vankle);

global HOPPER

s = hopperState;

% Hip velocity control:

% Hip gain.
phip = 30.0;

% Gain for kick - do only when the ankle slides outwards.
dhip = (vankle>0)*0.9;

% Gain for foot placement.
K = 0.2; % Gain

% Calculate desired hip angle.
hip1_des = -1.0*asin(s.top.rotation(2,3) + K*s.top.linearVel(2));
hip2_des = -1.0*atan2((s.top.rotation(1,3) + K*s.top.linearVel(1)),s.top.rotation(3,3));

% Calculate hip controls.
vhip1 = phip*(hip1_des - s.hip.angle1) - dhip*s.hip.angle1Rate;
vhip2 = phip*(hip2_des - s.hip.angle2) - dhip*s.hip.angle2Rate;

odeAPI('jointSetUniversalParam', HOPPER.hip.joint, 'Vel', vhip1);
odeAPI('jointSetUniversalParam', HOPPER.hip.joint, 'Vel2', vhip2);

% Direct ankle velocity control:

odeAPI('jointSetSliderParam', HOPPER.ankle.joint, 'Vel', vankle);
