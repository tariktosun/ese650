function K = gaussianKernel( X, centers, params )
% K = gaussianKernel( S, centers )
% Returns gaussian kernel function values for all states and all centers
% passed in.  Returned matrix K is NsxNc, where Ns is the number of state
% rows passed in and Nc is the number of center rows passed in.
sigma = params.sigma;
assert( size(X, 2) == size(centers, 2) );
[N,dim] = size(X);
[M, ~] = size(centers);

x = reshape(X, N,1,dim);
c = reshape(centers, 1,M,dim);
expterm = exp( (-1/(2*sigma^2))*sum( bsxfun(@minus, x, c).^2, 3 ) );
K = 1/(sqrt(2*pi)^dim * sigma^2) * expterm;
