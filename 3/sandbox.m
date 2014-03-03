%% Convert data to vector form

dataset = lpf;
X = {};
y = [];
for i=1:numel(names)
    X = cat(2, X, dataset.(names{i}));
    y = cat(1, y, ones(numel(dataset.(names{i})), 1)*i);
end
N = numel(y);
% Select only the appropriate fields:
for i=1:numel(X)
   % subsample by a factor of 5 
   subsample_idx = 1:5:size(X{i},1);
   X{i} = X{i}(subsample_idx,2:4); 
end


%% Test single-codebook quantization:
centers = kmSingleCodebook(X, 6);
% create one giant X matrix, and quantize:
x = [];
for i=1:numel(X)
    x = cat(1, x, X{i});
end
%x = [(1:size(x,1))', x];
xq = kmQuantize(x, centers);
% plot them:
plt_x = [(1:size(x,1))', x];
colors = {'r.', 'g.', 'b.', 'k.', 'm.', 'c.'};
figure;
for i=1:6
    visualize_acc(plt_x(xq==i,:), colors{i});
end
%%
wave_x = [];
wave_X = X(y==6);
for i=1:numel(wave_X)
    wave_x = cat(1, wave_x, wave_X{i});
end
wave_q = kmQuantize(wave_x, centers);
plt_wave = [(1:size(wave_x,1))', wave_x];
colors = {'r.', 'g.', 'b.', 'k.', 'm.', 'c.'};
figure;
for i=1:6
    if sum(wave_q==i)==0
        continue
    end
    visualize_acc(plt_wave(wave_q==i,:), colors{i});
end