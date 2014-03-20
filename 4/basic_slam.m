function [ pos_timeseries, map_timeseries ] = basic_slam( x0, data, params )
% [ pos_timeseries, map_timeseries ] = basic_slam( x0, data, params )
%
%% initialization
pos_timeseries = {};
map_timeseries = {};
%% step loop
for i=1:imax
    [output, slam_state] = step_slam( data{i}, slam_state{i-1}, output{i-1} );
    pos_timeseries{i} = output.pos;
    map_timeseries{i} = output.map;
end