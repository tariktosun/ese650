classdef test_a_priori < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        raw_data
        data
    end
    
    methods (TestMethodSetup)
        function setup(testCase)
            addpath(genpath('data'));
            % load data:
            load Encoders20.mat
            load Hokuyo20.mat
            imu = load('imuRaw20.mat');
            raw_data = struct();
            raw_data.Hokuyo = Hokuyo0;
            raw_data.Encoders = Encoders;
            raw_data.imu = imu;
            testCase.raw_data = raw_data;
            % clean the data:
            testCase.data = clean_data( testCase.raw_data );
        end
    end
    
    methods (Test)
        function test_step_odometry(testCase)
            
        end
        
    end
    
end

