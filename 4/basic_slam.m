function [ pos_timeseries, map ] = basic_slam( raw_data, params, start_idx, stop_idx )
% [ pos_timeseries, map_timeseries ] = basic_slam( x0, data, params )
%
%%
D = clean_data( raw_data );
if nargin==2
    start_idx = 1 ;
    stop_idx = numel(D.ts);
elseif nargin==3
    stop_idx = numel(D.ts);
end
%% initialization
%params = create_params();
map = create_map( params );
slam_state = initialize_slam_state(params);
pos_timeseries = zeros(3,stop_idx);

%
d = indexData(D,start_idx);
slam_state.time = d.ts;
xi = [0 0 0]';
Y = transform_range( xi, d.ranges, d.angles);
Yi = to_cell_indices(Y, params);
map = write_to_map( map, to_cell_indices(xi,params), Yi, 100, params);
%

%% step loop
figure;
for i=start_idx:stop_idx
    d = indexData(D,i);
    [pos, map, slam_state] = step_slam( d, slam_state, map, params );
    pos_timeseries(:,i) = pos;
    plot_world( pos, map, slam_state.particles, params );
    drawnow()
end