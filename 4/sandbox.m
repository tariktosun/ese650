load('Encoders20');
load('imuRaw20');
figure;
for i=1:4
    subplot(4,1,i);
    plot(Encoders.ts, Encoders.counts(i,:));
end