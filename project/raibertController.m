function raibertController( vxdes, vydes, vankle);
%% Extract hopper state    
global HOPPER
s = hopperState;
% Linear velocities:
vx = s.top.linearVel(1);
vy = s.top.linearVel(2);
% Attitude. pitch is about y, roll about x.
bodyRoll = -1.0*asin(s.top.rotation(2,3));
bodyPitch = -atan2(s.top.rotation(1,3),s.top.rotation(3,3));
bodyRollRate = s.top.angularVel(1);
bodyPitchRate = s.top.angularVel(2);
% Note that hipRoll/hipPitch are actually pitch and roll of the leg, NOT
% the angles the hip makes with the body.
hipRoll = s.hip.angle1;
hipPitch = s.hip.angle2;
hipRollRate = s.hip.angle1Rate;
hipPitchRate = s.hip.angle2Rate;

%% Gains and other constants
% Hip angle rate gains
pHip = (vankle>=0)*30.0;                          
%dHip = (vankle>0)*0.9;  % Derivative gain only when ankle slides outwards
dHip =0;
% foot placement gain
Kfoot = 0.2;
% Body attitude gains, active when foot is in contact with ground.
%pAtt = (vankle>0) * 10;
%dAtt = (vankle>0) * 0.1;
pAtt = 0; dAtt = 0;

%% Control laws
% desired foot placement
xfd = 0.5*vx + Kfoot*(vx-vxdes);
yfd = 0.5*vy + Kfoot*(vy-vydes);

% resulting desired hip pitch and roll
hipPitchDes = bodyPitch -asin(xfd/HOPPER.leg.length);
hipRollDes = bodyRoll + asin(yfd/HOPPER.leg.length);
% Hip velocity control:
vHip1 = pHip*(hipRollDes-hipRoll) - dHip*hipRollRate + ...
        pAtt*(bodyRoll-0) + dAtt*bodyRollRate;
vHip2 = pHip*(hipPitchDes-hipPitch) - dHip*hipPitchRate + ...
        pAtt*(bodyPitch-0) + dAtt*bodyPitchRate;
    
odeAPI('jointSetUniversalParam', HOPPER.hip.joint, 'Vel', vHip1);
odeAPI('jointSetUniversalParam', HOPPER.hip.joint, 'Vel2', vHip2);

% Direct ankle velocity control:
odeAPI('jointSetSliderParam', HOPPER.ankle.joint, 'Vel', vankle);