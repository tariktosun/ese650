function interactive_planner( map, cost_map )
% interactive_planner( map, cost_map )
% Allows the user to interactively plan paths on the map
figure;
imshow(map);
hold on
while(true)
endpoints = ginput(2);
start = floor(fliplr(endpoints(1,:)));
goal = floor(fliplr(endpoints(2,:)));
[path, ctg] = plan_path( cost_map, start, goal, [] );
plot(path(:,2), path(:,1), 'b.');
end