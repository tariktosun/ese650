function Ycell = to_cell_indices( Y, params )
% Ycell = to_cell( Y )
% Converts a series of values from meters to logical cells indices
%
%%
xs1 = Y(1,:);
ys1 = Y(2,:);
%convert from meters to cells
xis = ceil((xs1 - params.xmin) ./ params.res);
yis = ceil((ys1 - params.ymin) ./ params.res);

Ycell = [xis; yis];
end