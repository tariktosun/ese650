function plot_world( pos, map, params )
% plot_world( pos, map, params )
% Plots the world and robot.
imshow(-map);
hold on
pos_cell = to_cell_indices( pos, params );
plot( pos_cell(2), pos_cell(1), 'r*'); % flipped b/c image
hold off
end