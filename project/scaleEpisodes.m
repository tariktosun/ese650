function [means, stddevs] = getScale(data)
% scales = getScale(episodes)
% Extracts shift and scale required to mean-center and variance-scale
% data.
%
means = mean(data);
stddevs = std(data);