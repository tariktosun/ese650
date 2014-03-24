function slam_state = initialize_slam_state( params )
%
%
%%
slam_state.particles = zeros(3,params.NP);
slam_state.weights = ones(1,params.NP)*1/params.NP;
slam_state.time = 0;

end