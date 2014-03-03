%% Quantize the filtered data:
processed = cat(2, lpf.figure8, lpf.pend);
for i=1:numel(processed)
    processed{i} = processed{i}(:,2:4);
end
k = 6;
[ centers ] = kmSingleCodebook( processed, k );
quantized.figure8 = 
%% Learn an HMM:
%numHidden = 3*k;
numHidden = 2;
pTrans = 0.1;
Ai = eye(numHidden)*(1-pTrans) + diag( ones(numHidden-1, 1), 1 )*pTrans;
Ai(numHidden, 1) = pTrans;
bi = ones(numHidden, k)/numHidden;
%% train HMM for figure8:
[f8Trans, f8Emit] = hmmtrain( quantized.figure8, Ai, bi, 'Verbose', true);
%% train HMM for pendulum:
[pTrans, pEmit] = hmmtrain( quantized.pend, Ai, bi, 'Verbose', true);
%% Estimate training error:
f8LpF8 = 0;
f8LpP = 0;
pLpP = 0;
pLpF8 = 0;
for i=1:numel(quantized.pend)
    [~,Lp] = hmmdecode(quantized.pend{i},f8Trans,f8Emit);
    pLpF8 = pLpF8 + Lp;
    [~,Lp] = hmmdecode(quantized.pend{i},pTrans,pEmit);
    pLpP = pLpP + Lp;
end
for i=1:numel(quantized.figure8)
    [~,Lp] = hmmdecode(quantized.figure8{i},f8Trans,f8Emit);
    f8LpF8 = f8LpF8 + Lp;
    [~,Lp] = hmmdecode(quantized.figure8{i},pTrans,pEmit);
    f8LpP = f8LpP + Lp;
end
pLpP = pLpP / numel(quantized.pend)
pLpF8 = pLpF8 / numel(quantized.pend)
f8LpP = f8LpP / numel(quantized.figure8)
f8LpF8 = f8LpF8 / numel(quantized.figure8)