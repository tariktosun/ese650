function c = correlation( map, Y, params )
% c = correlation( Map, Y, params )
% 
%%
assert( size(Y,2) == 4 );
x_im = params.xmin:params.res:params.xmax; %x-positions of each pixel of the map
y_im = params.ymin:params.res:params.ymax; %y-positions of each pixel of the map
x_range = -1:0.05:1;
y_range = -1:0.05:1;
%%
c = map_correlation(map, x_im, y_im, Y(1:3,:), x_range, y_range);
c = norm( c, 'fro' ); % why not
end