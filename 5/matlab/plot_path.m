function plot_path( path, start, goal, costs, ctg )
% plot_path( path, start, goal, costs, ctg )
% Plots the path.
%
if nargin == 3
    plot_cost = false;
else
    plot_cost = true;
end

subplot(1,2,1);
if plot_cost
    imagesc(costs,[1 10]);
    colormap(1-gray);
end
hold on;
%plot(jp1, ip1, 'b-', jp2, ip2, 'r-');
plot(path(:,2), path(:,1));
plot(start(2), start(1), 'ro');
plot(goal(2), goal(1), 'g*');
hold off;

subplot(1,2,2);
if plot_cost
    imagesc(ctg);
    colormap(1-gray);
end
hold on;
%plot(jp1, ip1, 'b-', jp2, ip2, 'r-');
plot(path(:,2), path(:,1));
plot(start(2), start(1), 'ro');
plot(goal(2), goal(1), 'g*');
hold off;
