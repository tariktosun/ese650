function qstates = runHopper(initial, gains, N, dt, makePlot)
% runs the Hopper for one episode.
a0 = initial;

hopperReset(a0);

kick_thresh = 0.1;
%N = 1000;
s = hopperState;
states = repmat( s, N, 1 );
%dt = 0.01;
for isim = 1:N,
  hopperStep(dt);

  s = hopperState;
  states(isim) = s;
  if (s.foot.position(3) < kick_thresh)
  % Extend:
    vankle = +100.0;
  else
  % Retract:
    vankle = 0;
  end
  
  raibertController( 0, 0, vankle, gains );

  if makePlot
      hopperPlot;
      title(sprintf('Step: %d', isim));
      axis([s.top.position(1)+[-2 2] s.top.position(2)+[-2 2] 0 3]);
      view(30, 15);
      grid on;
  end
  drawnow
  
end

extractHopperStates;
qstates = [ topLinearVelocity(1,:)', topLinearVelocity(2,:)', bodyRoll', ...
            bodyPitch', hipRoll', hipPitch' ];