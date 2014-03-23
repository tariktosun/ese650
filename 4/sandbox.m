%% Initialize parameters
params = struct();
% map parameters:
params.res   = 0.05; %meters
params.xmin  = -40;  %meters
params.ymin  = -40;
params.xmax  =  40;
params.ymax  =  40;
%dimensions of the map
params.sizex  = ceil((params.xmax - params.xmin) / params.res + 1); %cells
params.sizey  = ceil((params.ymax - params.ymin) / params.res + 1);
% 
%% Call basic_slam:
