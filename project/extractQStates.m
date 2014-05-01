function qstates = extractQStates(states)
% qstates = extractQStates(states)
% Extracts states for Q learning, returns as an Nx6 matrix.
% States are [ xdot ydot roll pitch hipRoll hipPitch ]
extractHopperStates;
qstates = [ topLinearVelocity(1,:)', topLinearVelocity(2,:)', bodyRoll', ...
            bodyPitch', hipRoll', hipPitch' ];
end