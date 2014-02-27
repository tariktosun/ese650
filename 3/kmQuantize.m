function [ quantized, centers ] = kmQuantize( data, k )
% Performs kmeans quantization on data.
names = {'circle', 'figure8', 'fish', 'hammer', 'pend', 'wave'};
centers = data;
quantized = data;

for i=1:numel(names)
    name = names{i};
    motion = data.(char(name));
%     centers.(char(name)) = {};
%     quantized.(char(name)) = {};
    for j=1:numel(motion)
        [idx, ctrs] = kmeans(motion{j}, k);     % perform kmeans
        quantized.(char(name)){j} = idx;
        centers.(char(name)){j} = ctrs;
    end
end