% Script which runs code on the test set:
%% Load the model
load model.mat
names = {'circle', 'figure8', 'fish', 'hammer', 'pend', 'wave'};
%% Load the testing data:
Xtest = {};
%{
Xtest{1} = load('test/trim01');
Xtest{2} = load('test/trim02');
Xtest{3} = load('test/trim03');
Xtest{4} = load('test/trim04');
Xtest{5} = load('test/trim05');
Xtest{6} = load('test/trim06');
%}
%

Xtest{1} = load('test/fix01');
Xtest{2} = load('test/fix02');
Xtest{3} = load('test/fix03');
Xtest{4} = load('test/fix04');
Xtest{5} = load('test/fix05');
Xtest{6} = load('test/fix06');
%}
%% Low-pass filter the testing data and extract accelerations only:
sampletime = 0.0101;  % average of
rate = 1/sampletime;
low_hz = 0.2;   % period of 5 seconds
hi_hz = 10;     % 10 cycles / second
range = [low_hz hi_hz] / (rate * pi);
filt = fir1(80, range , 'band');

for i=1:numel(Xtest)
    Xtest{i}(:,2:end) = filtfilt(filt, 1, Xtest{i}(:,2:end));
    Xtest{i} = Xtest{i}(:,2:4);
end
%% Classify the testing data:
labels = [1,2,3,4,5,6];
[yhat, scores] = gestureModelClassify(Xtest, hmmModel, centers, labels);
names(yhat)
%% Visualize the accelerations:

num = 5;
figure;
plot3(Xtest{num}(:,1), Xtest{num}(:,2), Xtest{num}(:,3), '.');

