T = test_a_priori();
%T.test_transform_range();
%T.run('test_open_loop_correlation');
%T.run('test_step_odometry');
T.run('test_motion_model')