function hopperControl(hip1, hip2, vankle);

global HOPPER

s = hopperState;

% Hip velocity control:

phip = 20.0;
dhip = 0;
vhip1 = phip*(hip1 - s.hip.angle1) - dhip*s.hip.angle1Rate;
vhip2 = phip*(hip2 - s.hip.angle2) - dhip*s.hip.angle2Rate;

odeAPI('jointSetUniversalParam', HOPPER.hip.joint, 'Vel', vhip1);
odeAPI('jointSetUniversalParam', HOPPER.hip.joint, 'Vel2', vhip2);

% Direct ankle velocity control:

odeAPI('jointSetSliderParam', HOPPER.ankle.joint, 'Vel', vankle);
