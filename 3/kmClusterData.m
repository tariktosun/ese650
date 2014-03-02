function [ quantized, centers ] = kmClusterData( varargin )
% Performs kmeans quantization on the full data set.
if nargin==2
    data = varargin{1};
    k = varargin{2};
    useNames = true;
    labels = [1 2 3 4 5];
    centers = struct();
    quantized = struct();
elseif nargin==4
    X = varargin{1};
    y = varargin{2};
    k = varargin{3};
    labels = varargin{4};
    useNames = false;
    centers = {};       % will be numSymbols long.
    quantized = {};     % will by numExamples long.
else
    assert(false)
end


names = {'circle', 'figure8', 'fish', 'hammer', 'pend', 'wave'};

%for i=1:numel(names)
for i=labels
    if useNames
        name = names{i};
        motion = data.(char(name));
    else
        motion = X( y==i );
    end
    m = [];
    %% Find KMeans cluster centers using full dataset for each motion:
    for j=1:numel(motion)
        m = cat(1, m, motion{j});
    end
    %m = m(:, 2:7);  % use only acc and gyro
    [~, ctrs] = kmeans(m, k);     % perform kmeans
    %quantized.(char(name)) = idx;
    %% Quantize each data set with these cluster centers:
    q = {};
    for j=1:numel(motion)
        %q{j} = kmQuantize(motion{j}(:,2:7), ctrs)';
        q{j} = kmQuantize(motion{j}, ctrs)';
    end
    if useNames
        centers.(char(name)) = ctrs;
        quantized.(char(name)) = q;
    else
        centers{i} = ctrs;
        quantized = cat(2, quantized, q);
    end
end
end