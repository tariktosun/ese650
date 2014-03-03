%% Low-pass filter:
sampletime = 0.0101;  % average of
rate = 1/sampletime;
low_hz = 0.2;   % period of 5 seconds
hi_hz = 10;     % 10 cycles / second
range = [low_hz hi_hz] / (rate * pi);

filt = fir1(80, range , 'band');
freqz(filt, 1, 512);
%% Apply filter:
lpf = train;
names = {'circle', 'figure8', 'fish', 'hammer', 'pend', 'wave'};
for i=1:numel(names)
    motion = lpf.(char(names{i}));
    for j=1:numel(motion)
        dataset = motion{j};
        dataset = dataset(:,2:end); % don't filter time.
        lpf.(char(names{i})){j}(:,2:end) = filtfilt(filt, 1, dataset);
    end
end