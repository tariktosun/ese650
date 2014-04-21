function y = hopperInit

global HOPPER

if ~isempty(HOPPER),
  warning('Hopper structure already exists.');
  y = [];
  return;
end

HOPPER.top.mass = 1.0;
HOPPER.top.radius = 1.0;
HOPPER.top.height = 0.1;
HOPPER.top.z0 = 2.0;
HOPPER.top.body = odeAPI('bodyCreate');
odeAPI('bodySetMassCylinder', HOPPER.top.body, ...
       HOPPER.top.mass, [3 HOPPER.top.radius HOPPER.top.height]);
HOPPER.top.geom = odeAPI('createCylinder', ...
                         [HOPPER.top.radius HOPPER.top.height]);
odeAPI('geomSetBody', HOPPER.top.geom, HOPPER.top.body);
odeAPI('bodySetPosition', HOPPER.top.body, [0 0 HOPPER.top.z0]);

HOPPER.leg.mass = 0.1;
HOPPER.leg.radius = 0.01;
HOPPER.leg.length = 1.0;
HOPPER.leg.body = odeAPI('bodyCreate');
odeAPI('bodySetMassCylinder', HOPPER.leg.body, ...
       HOPPER.leg.mass, [3 HOPPER.leg.radius HOPPER.leg.length]);
HOPPER.leg.geom = odeAPI('createCCylinder', ...
                         [HOPPER.leg.radius HOPPER.leg.length]);
odeAPI('geomSetBody', HOPPER.leg.geom, HOPPER.leg.body);
odeAPI('bodySetPosition', HOPPER.leg.body, ...
       [0 0 HOPPER.top.z0-.5*HOPPER.leg.length]);

HOPPER.foot.mass = 0.01;
HOPPER.foot.radius = 0.01;
HOPPER.foot.body = odeAPI('bodyCreate');
odeAPI('bodySetMassSphere', HOPPER.foot.body, ...
       HOPPER.foot.mass, HOPPER.foot.radius);
HOPPER.foot.geom = odeAPI('createSphere', HOPPER.foot.radius);
odeAPI('geomSetBody', HOPPER.foot.geom, HOPPER.foot.body);
odeAPI('bodySetPosition', HOPPER.foot.body, ...
       [0 0 HOPPER.top.z0-HOPPER.leg.length]);

HOPPER.hip.torque = 100.0;
HOPPER.hip.joint = odeAPI('jointCreateUniversal');
odeAPI('jointAttach', HOPPER.hip.joint, HOPPER.top.body, HOPPER.leg.body);
odeAPI('jointSetUniversalAnchor', HOPPER.hip.joint, [0 0 HOPPER.top.z0]);
odeAPI('jointSetUniversalAxis1', HOPPER.hip.joint, [1 0 0]);
odeAPI('jointSetUniversalAxis2', HOPPER.hip.joint, [0 1 0]);
odeAPI('jointSetUniversalParam', HOPPER.hip.joint, 'LoStop', -pi/4);
odeAPI('jointSetUniversalParam', HOPPER.hip.joint, 'HiStop', +pi/4);
odeAPI('jointSetUniversalParam', HOPPER.hip.joint, 'FMax', HOPPER.hip.torque);
odeAPI('jointSetUniversalParam', HOPPER.hip.joint, 'LoStop2', -pi/4);
odeAPI('jointSetUniversalParam', HOPPER.hip.joint, 'HiStop2', +pi/4);
odeAPI('jointSetUniversalParam', HOPPER.hip.joint, 'FMax2', HOPPER.hip.torque);

HOPPER.ankle.force = 50.0;
HOPPER.ankle.length = 0.2;
HOPPER.ankle.joint = odeAPI('jointCreateSlider');
odeAPI('jointAttach', HOPPER.ankle.joint, HOPPER.leg.body, HOPPER.foot.body);
odeAPI('jointSetSliderAxis', HOPPER.ankle.joint, [0 0 1]);
odeAPI('jointSetSliderParam', HOPPER.ankle.joint, 'LoStop', 0);
odeAPI('jointSetSliderParam', HOPPER.ankle.joint, 'HiStop', ...
       HOPPER.ankle.length);
odeAPI('jointSetSliderParam', HOPPER.ankle.joint, 'FMax', HOPPER.ankle.force);

HOPPER.ground.geom = odeAPI('createPlane',[0 0 1 0]);

y = HOPPER;

