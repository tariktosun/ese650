function path = plan_path( cost_map, start, goal, params )
% path = plan_path( cost_map, start, goal, params )
% Plans path from start to goal given costmap.  start and goal must be
% [x,y] pairs.
%
%% get cost-to-go
goal = [250 1000];
tic;
ctg = dijkstra_matrix(cost_map ,goal(1),goal(2));
toc

%[ip1, jp1] = dijkstra_path(ctg, costs, 1, 1);
[ip2, jp2] = dijkstra_path2(ctg, cost_map, 1, 1);
path = [ip2, jp2];  % Note: plotting appears xy backwards?
%% Plotting from example:
%{
subplot(1,2,1);
imagesc(costs,[1 10]);
colormap(1-gray);
hold on;
plot(jp1, ip1, 'b-', jp2, ip2, 'r-');
hold off;

subplot(1,2,2);
imagesc(ctg);
colormap(1-gray);
hold on;
plot(jp1, ip1, 'b-', jp2, ip2, 'r-');
hold off;
%}  
    