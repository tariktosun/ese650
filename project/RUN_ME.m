% Run this script to see the Hopper hopping under the optimal Q-learned
% policy.
load qdata1.mat
Qdata.Qvals = Qdata.QvalsHistory(:,1);
gatherMeshData