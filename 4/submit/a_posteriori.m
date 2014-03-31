function [slam_state, map] = a_posteriori( slam_state, map, data, params )
% [a_posteriori_weights, a_posteriori_map] = ...
%    a_posteriori( a_priori_particles, p_output.map, params )
%
%%
a_priori_particles = slam_state.particles;
a_priori_weights = slam_state.weights;
a_posteriori_weights = a_priori_weights;
NP = size(a_priori_particles,2);
Y = cell(1,NP);
Yind = cell(1,NP);
%% Apply xforms to Hokuyo measurements, and transform to from meters to cells:
for i=1:NP
    % Apply xforms
    Y{i} = transform_range( a_priori_particles(:,i), data.ranges, data.angles ); % {P}x3x1081 array
    % convert to cell indices:
    Yind{i} = to_cell_indices( Y{i}, params ); % 1x1081 (or fewer) indices.
end
%% Compute a map correlation value for each particle:
for i=1:NP
    %compute correlation
    c = correlation( map, Y{i}, params );
    c = c + min(c);
    %c(c<0)=0;
    a_posteriori_weights(i) = a_priori_weights(i) .* c;
end
%if sum(a_posteriori_weights) == 0
%    a_posteriori_weights = ones(1,NP)/NP;
%else
    a_posteriori_weights = a_posteriori_weights / sum( a_posteriori_weights );  % Normalize
%end
slam_state.weights = a_posteriori_weights;
%% Compute a posteriori map:
for i=1:NP
    map = write_to_map( map, to_cell_indices(a_priori_particles(:,i),params), Yind{i}, a_posteriori_weights(i), params);
end
end
