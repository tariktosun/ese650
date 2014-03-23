function [ pos_timeseries, map ] = basic_slam( x0, raw_data, params )
% [ pos_timeseries, map_timeseries ] = basic_slam( x0, data, params )
%
%% initialization
data = clean_data( raw_data );

pos_timeseries = zeros(3,numel(data.ts));
map = create_map( params );
%% step loop
for i=2:imax
    d = indexData(data,i);
    [pos, map, slam_state] = step_slam( d, slam_state, map, params );
    pos_timeseries(:,i) = output.pos;
end