function c = correlation( map, Y, params )
% c = correlation( Map, Y, params )
% 
%%
assert( size(Y,1) == 4 );
x_im = params.xmin:params.res:params.xmax; %x-positions of each pixel of the map
y_im = params.ymin:params.res:params.ymax; %y-positions of each pixel of the map
%%
c = map_correlation(map, x_im, y_im, Y(1:3,:), params.correlation_x_range, params.correlation_y_range);
c = max(c(:));
end