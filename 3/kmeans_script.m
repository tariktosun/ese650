
%% Explore / plot:
addpath ~/Dropbox/cookbook/varycolor/
%f8 = [lpf.figure8{1}; lpf.figure8{2}; lpf.figure8{3}];
f8 = lpf.fish{2};
t = f8(:,1);
f8_acc = f8(:,2:4);
%figure; plot3(f8_acc(:,1), f8_acc(:,2), f8_acc(:,3), '.')
nolpf = train.figure8{1}(:,2:4);
%figure; plot3(nolpf(:,1), nolpf(:,2), nolpf(:,3), '.')
%% Perform KMeans:
k = 8;
[idx, ctrs] = kmeans(f8_acc, k);
%% plot:
figure;
colors = varycolor(k);
for i=1:k
    plot3(f8_acc(idx==i,1), f8_acc(idx==i,2), f8_acc(idx==i,3), 'Color', colors(i,:), 'Marker', '.');
    hold on;
end
%% attempt to generate new data with an HMM:
% use ten states, even distribution to begin.
%{
selftrans = eye(10)*(k-1)/k;
nexttrans = [zeros(10,1) eye(10)*1/k];
transGuess = selftrans + nexttrans(:,1:end-1);
emitGuess = ones(k)/k;
%}

%transGuess = ones(k)*0.001 + eye(k);
%emitGuess = ones(k)*0.001 + eye(k);
%transGuess = [0.95 0.04 0.01; 0.01 0.95 0.04; 0.04 0.01 0.95];
%emitGuess = [0.8 0.1 0.1; 0.1 0.8 0.1; 0.1 0.1 0.8];

transGuess = rand(k);
transGuess = bsxfun(@rdivide, transGuess, sum(transGuess,2));
emitGuess = rand(k);
emitGuess = bsxfun(@rdivide, emitGuess, sum(emitGuess,2));
[trans,emit] = hmmtrain(idx',transGuess,emitGuess, 'Verbose', true);
%% test generation:
seq = hmmgenerate(1000, trans, emit);

%%
trans = [0.95,0.05;
      0.10,0.90];
emis = [1/6, 1/6, 1/6, 1/6, 1/6, 1/6;
   1/10, 1/10, 1/10, 1/10, 1/10, 1/2];

seq1 = hmmgenerate(100,trans,emis);
seq2 = hmmgenerate(200,trans,emis);
seqs = {seq1,seq2};
[estTR,estE] = hmmtrain(seqs,trans,emis, 'Verbose', true);

%% Using kmQuantize now:


