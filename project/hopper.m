clear all;
close all;
clc;

global HOPPER

if isempty(HOPPER),
  hopperInit;
end

a0 = 2*pi/20*randn(1);
hopperReset(a0);
dt = 0.01;
for isim = 1:1000,
  hopperStep(dt);

  s = hopperState;

  if (s.foot.position(3) < .1)
  % Extend:
    vankle = +100.0;
  else
  % Retract:
    vankle = -1.0;
  end

  hip1 = -1.0*asin(s.top.rotation(2,3));
  hip2 = -1.0*atan2(s.top.rotation(1,3),s.top.rotation(3,3));
  
  %hopperControl1(hip1, hip2, vankle);
  hopperControl2(hip1, hip2, vankle);
  %raibertController( 0, 0, vankle );

  hopperPlot;
  title(sprintf('Step: %d', isim));
  axis([s.top.position(1)+[-2 2] s.top.position(2)+[-2 2] 0 3]);
  view(30, 15);
  grid on;
  drawnow
end