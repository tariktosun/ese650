function [a_posteriori_weights, a_posteriori_map] = ...
    a_posteriori( a_priori_particles, p_output.map, ranges, angles, params )
% [a_posteriori_weights, a_posteriori_map] = ...
%    a_posteriori( a_priori_particles, p_output.map, params )
%
%% Apply xforms to Hokuyo measurements, and transform to from meters to cells:
for i=1:num_particles
    % Apply xforms
    Y{i} = transform_range( a_priori_particles(:,i), ranges, angles ); % {P}x3x1081 array
    % convert to cell indices:
    Yind{i} = to_cell( Y{i} ); % 1x1081 (or fewer) indices.
end
%% Compute a map correlation value for each particle:
for i=1:num_particles
    %compute correlation
    c = correlation( map, Y{i}, params );
    a_posteriori_weights(i) = a_priori_weights .* c;
end
%% Compute a posteriori map:
for i=1:num_particles
    % generate rays:
    getMapCellsFromRay();
    % Add rays as free space:
        % weight appropriately
    % Add endpoints as filled space:
end
end
