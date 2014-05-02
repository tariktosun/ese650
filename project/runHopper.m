function [qstates, gainHistory] = runHopper(initial, policy, N, dt, useQ, makePlot)
% runs the Hopper for one episode.
if useQ
    Qdata = policy;
else
    gains = policy;
end

gainHistory = zeros(N,3);
Qhistory = zeros(N,1);


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
  % test for failure:
  if failureCriterion(s)
      states = states(1:isim);
      break;
  end
  
  states(isim) = s;
  if (s.foot.position(3) < kick_thresh)
  % Extend:
    vankle = +100.0;
  else
  % Retract:
    vankle = 0;
  end
  
  if useQ
      [Qval, gains] = getGains(s, Qdata);
      gainHistory(isim, :) = gains;
      Qhistory(isim) = Qval;
  end
  raibertController( 0, 0, vankle, gains );

  if makePlot
      clf
      subplot(4,2,[1,3,5,7]);
      hopperPlot;
      title(sprintf('Step: %d', isim));
      axis([s.top.position(1)+[-2 2] s.top.position(2)+[-2 2] 0 3]);
      view(30, 15);
      grid on;
      %
      h = 150;
      %tplot = [max(isim-h,1):isim];
      tplot = [1:isim];
      xmin = isim-h;
      %g = gainHistory(max(isim-h,1):isim,:);
      g = gainHistory;
      subplot(4,2,2);
      fp = plot(tplot, g(1:isim, 1), 'k-');
      xlim([xmin, isim+10]);
      hold on; title('Kfoot'); hold off;
      subplot(4,2,4);
      pp = plot(tplot, g(1:isim,2), 'b-');
      xlim([xmin, isim+10]);
      hold on; title('pAtt'); hold off;
      subplot(4,2,6);
      dp = plot(tplot, g(1:isim,3), 'r-');
      xlim([xmin, isim+10]);
      hold on; title('dAtt'); hold off;
      gainPlots = [fp, pp, dp];
      subplot(4,2,8);
      plot(tplot, Qhistory(1:isim), 'm-');
      xlim([xmin, isim+10]);
      hold on; title('Q'); hold off;
      drawnow
  end
  
  
end

extractHopperStates;
qstates = [ topLinearVelocity(1,:)', topLinearVelocity(2,:)', bodyRoll', ...
            bodyPitch', hipRoll', hipPitch' ];