function failed = failureCriterion(state)
% failed = failureCriterion(state)
% returns true if state constitutes failure.
ztop = state.top.position(3);
bodyVector = state.top.rotation*[0 0 1]';
failed = ztop/(norm(cross(bodyVector,[0 0 1]'))) < 1.1;