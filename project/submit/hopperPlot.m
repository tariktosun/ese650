function h = hopperPlot

global HOPPER

s = hopperState;

ntop = 40;
xtop0 = [HOPPER.top.radius*cos(2*pi*[0:ntop]/ntop);
        HOPPER.top.radius*sin(2*pi*[0:ntop]/ntop);
        zeros(1,ntop+1)];
xtop = repmat(s.top.position,[1 ntop+1]) + s.top.rotation'*xtop0;

xleg0 = [0 0; 0 0; HOPPER.leg.length*[0.5 -0.5]];
xleg = repmat(s.leg.position,[1 2]) + s.leg.rotation'*xleg0;

xfoot = s.foot.position;

htop = plot3(xtop(1,:), xtop(2,:), xtop(3,:), 'b-');

hold on;
hfoot = plot3(xfoot(1), xfoot(2), xfoot(3), 'o');
hleg = plot3(xleg(1,:), xleg(2,:), xleg(3,:), 'k-');
hold off;

h = [htop; hfoot; hleg];
