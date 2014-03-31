function plot_world( pos, map, particles, params )
% plot_world( pos, map, params )
% Plots the world and robot.
imshow(-map);
hold on
pos_cell = to_cell_indices( pos, params );
plot( pos_cell(2), pos_cell(1), 'r*'); % flipped b/c image
for i=1:size(particles,2)
    idx = to_cell_indices( particles(:,i), params );
    plot( idx(2), idx(1), 'b.');
end
hold off
end