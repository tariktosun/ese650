classdef test_slam < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        raw_data
        raw_test
    end
    
    methods (TestMethodSetup)
        function setup(testCase)
            addpath(genpath('~/Dropbox/cookbook'));
            addpath(genpath('data'));
            % load data:
            names = {'20', '21', '22', '23', '24'};
            raw_data = {};
            for i=1:numel(names)
                load(['Encoders' names{i} '.mat']);
                load(['Hokuyo' names{i} '.mat']);
                imu = load(['imuRaw' names{i} '.mat']);
                raw = struct();
                raw.Hokuyo = Hokuyo0;
                raw.Encoders = Encoders;
                raw.imu = imu;
                raw_data{i} = raw;
            end
            testCase.raw_data = raw_data;
            % get test set data:
            addpath(genpath('test'));
            test_names = {'1', '2', '3'};
            raw_test = {};
            for i=1:numel(test_names)
                load(['Encoders_test' test_names{i} '.mat']);
                load(['Hokuyo_test' test_names{i} '.mat']);
                imu = load(['imuRaw_test' test_names{i} '.mat']);
                raw = struct();
                raw.Hokuyo = Hokuyo0;
                raw.Encoders = Encoders;
                raw.imu = imu;
                raw_test{i} = raw;
            end
            testCase.raw_test = raw_test;
        end
    end
    
    methods (Test)
        %% test slam!
        function test_basic_slam(testCase)
            params = create_params(1);
            basic_slam(testCase.raw_data{2}, params, 500);
        end
        %% test set
        function test_test_set(testCase)
           params = create_params(5);
           basic_slam(testCase.raw_test{1}, params); 
        end
    end
end

