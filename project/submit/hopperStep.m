function y = hopperStep(dt)

if nargin < 1,
  dt = 0.1;
end

tstep = 1E-4;
for istep = 1:dt/tstep,
  odeAPI('worldQuickStep', tstep);
end

