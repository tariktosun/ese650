function [a_posteriori_weights, a_posteriori_map] = ...
    a_posteriori( a_priori_particles, p_output.map, params )
% [a_posteriori_weights, a_posteriori_map] = ...
%    a_posteriori( a_priori_particles, p_output.map, params )
%
%% Compute Hokuyo-to-world xforms for each particle:
% Compute xform from Hokuyo to IMU frame:

% Compute IMU-to-world xforms for each particle:

% Compose xforms:
%% Apply xforms to Hokuyo measurements, and transform to from meters to cells:
% Apply xforms

% Transform to cells

    % Px3x1081 array
%% Compute a map correlation value for each particle:

% ( this is rough )
x_im = MAP.xmin:MAP.res:MAP.xmax; %x-positions of each pixel of the map
y_im = MAP.ymin:MAP.res:MAP.ymax; %y-positions of each pixel of the map

x_range = -1:0.05:1;
y_range = -1:0.05:1;
for i=1:num_particles
    %compute correlation
    c = map_correlation(MAP.map,x_im,y_im,Y(1:3,:),x_range,y_range);
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
