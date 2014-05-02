function s = hopperState;

global HOPPER

s.top.position = odeAPI('bodyGetPosition', HOPPER.top.body);
s.top.rotation = odeAPI('bodyGetRotation', HOPPER.top.body);
s.top.rotation(4,:) = [];
s.top.linearVel = odeAPI('bodyGetLinearVel', HOPPER.top.body);
s.top.angularVel = odeAPI('bodyGetAngularVel', HOPPER.top.body);

s.leg.position = odeAPI('bodyGetPosition', HOPPER.leg.body);
s.leg.rotation = odeAPI('bodyGetRotation', HOPPER.leg.body);
s.leg.rotation(4,:) = [];
s.leg.linearVel = odeAPI('bodyGetLinearVel', HOPPER.leg.body);
s.leg.angularVel = odeAPI('bodyGetAngularVel', HOPPER.leg.body);

s.foot.position = odeAPI('bodyGetPosition', HOPPER.foot.body);

s.hip.angle1 = odeAPI('jointGetUniversalAngle1', HOPPER.hip.joint);
s.hip.angle1Rate = odeAPI('jointGetUniversalAngle1Rate', HOPPER.hip.joint);
s.hip.angle2 = odeAPI('jointGetUniversalAngle2', HOPPER.hip.joint);
s.hip.angle2Rate = odeAPI('jointGetUniversalAngle2Rate', HOPPER.hip.joint);

s.ankle.position = odeAPI('jointGetSliderPosition', HOPPER.ankle.joint);
s.ankle.positionRate = odeAPI('jointGetSliderPositionRate', HOPPER.ankle.joint);
