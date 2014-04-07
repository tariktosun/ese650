function example_path = draw_example( map, params )
% example_path = draw_example( map, params )
% Allows you to draw an example path on the map.
%
figure
imshow( map );
waypoints = ginput();
x = waypoints(:,2);
y = waypoints(:,1);
np = size(waypoints, 1);
example_path = [];
for i=1:np-1
    [linex, liney] = getMapCellsFromRay(x(i), y(i), [x(i+1)], [y(i+1)]);
    example_path = cat( 1, example_path, flipud([linex, liney]) );
end
% add in last point:
example_path = cat( 1, example_path, [x(np), y(np)] );
    
    
    