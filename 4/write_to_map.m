function map = write_to_map( map, loc, scan_cells, weight, params )
% map = write_to_map( cells )
% Writes cells to map with given weights.  Clear cells as well.
%% closed cells
%check the indices and populate the map for closed cells:
xis = scan_cells(1,:);
yis = scan_cells(2,:);
indGood = (xis > 1) & (yis > 1) & (xis < params.sizex) & (yis < params.sizey);
Yind = sub2ind([params.sizex, params.sizey],xis(indGood),yis(indGood));
map(Yind) = map(Yind) + int8(ones(1,numel(Yind)))*weight;
%% get open cells, and do the same
[xis,yis] = getMapCellsFromRay(loc(1), loc(2), scan_cells(1,:), scan_cells(2,:));
xis = xis'; yis = yis';
indGood = (xis > 1) & (yis > 1) & (xis < params.sizex) & (yis < params.sizey);
Yind = sub2ind([params.sizex, params.sizey],xis(indGood),yis(indGood));
map(Yind) = map(Yind) - int8(ones(1,numel(Yind)))*weight;