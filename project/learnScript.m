%% assumes scaledEpisodes is in workspace.
%params = generateParams();
%%
%[ centers, Qvals ] = initQ( scaledEpisodes, params.numCenters, N );
%%
Qvals = Qlearn( episodes, centers, Qvals, params );