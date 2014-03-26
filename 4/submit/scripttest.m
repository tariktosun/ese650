T = test_a_posteriori();
%T.test_transform_range();
%T.run('test_open_loop_correlation');
%T.run('test_step_odometry');
%T.setup();
T.test_full_a_posteriori();