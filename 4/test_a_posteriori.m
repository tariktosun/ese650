classdef test_a_posteriori < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        raw_data
        data
        names
    end
    
    methods (TestMethodSetup)
        function setup(testCase)
            addpath(genpath('data'));
            % load data:
            testCase.names = {'20', '21', '22', '23', '24'};
            testCase.raw_data = {};
            testCase.data = {};
            for i=1:numel(testCase.names)
                load(['Encoders' testCase.names{i} '.mat']);
                load(['Hokuyo' testCase.names{i} '.mat']);
                imu = load(['imuRaw' testCase.names{i} '.mat']);
                raw_data = struct();
                raw_data.Hokuyo = Hokuyo0;
                raw_data.Encoders = Encoders;
                raw_data.imu = imu;
                testCase.raw_data{i} = raw_data;
                % clean the data:
                testCase.data{i} = clean_data( raw_data );
            end
        end
    end
    
    methods (Test)
        function test_transform(testCase)
            H = 
        end
        
    end
    
end

