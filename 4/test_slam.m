classdef test_slam < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        raw_data
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
        end
    end
    
    methods (Test)
        %% test slam!
        function test_basic_slam(testCase)
            basic_slam(testCase.raw_data{1}, 500);
        end
    end
end

