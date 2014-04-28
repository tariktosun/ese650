function hopperReset(a0)

if nargin < 1,
  a0 = 0;
end
r = [cos(a0) 0 sin(a0); 0 1 0; -sin(a0) 0 cos(a0)];
r(4,:) = 0;

r0 = eye(3,3);
r0(4,:) = 0;

global HOPPER

odeAPI('bodySetPosition', HOPPER.top.body, [0 0 HOPPER.top.z0]);
odeAPI('bodySetRotation', HOPPER.top.body, r);
odeAPI('bodySetLinearVel', HOPPER.top.body, [0 0 0]);
odeAPI('bodySetAngularVel', HOPPER.top.body, [0 0 0]);

odeAPI('bodySetPosition', HOPPER.leg.body, ...
       [0 0 HOPPER.top.z0-.5*HOPPER.leg.length]);
odeAPI('bodySetRotation', HOPPER.leg.body, r0);
odeAPI('bodySetLinearVel', HOPPER.leg.body, [0 0 0]);
odeAPI('bodySetAngularVel', HOPPER.leg.body, [0 0 0]);

odeAPI('bodySetPosition', HOPPER.foot.body, ...
       [0 0 HOPPER.top.z0-(HOPPER.leg.length+HOPPER.ankle.length)]);
odeAPI('bodySetRotation', HOPPER.foot.body, r0);
odeAPI('bodySetLinearVel', HOPPER.foot.body, [0 0 0]);
odeAPI('bodySetAngularVel', HOPPER.foot.body, [0 0 0]);