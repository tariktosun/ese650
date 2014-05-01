%% assumes scaledEpisodes is in workspace.
params = generateParams();
%%
%[ centers, Qvals ] = initQ( scaledEpisodes, params.numCenters, N );
%%
Qvals = Qlearn( scaledEpisodes, centers, Qvals, params );
Qdata = struct();
Qdata.Qvals = Qvals;
Qdata.centers = centers;
Qdata.means = m;
Qdata.stddevs = stddev;
Qdata.params = params;
%% rescale the data and report best Q's:
realCenters = bsxfun( @plus, bsxfun( @times, centers, stddev ), m);
[Qmax, idx] = max(Qvals);
realCenters(idx, 7:end)

