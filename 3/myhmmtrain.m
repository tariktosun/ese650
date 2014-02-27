% MYHMMTRAIN - Wrapper on HMMTRAIN that removes "initial state" effects

  function [ T, H ] = myhmmtrain( y, T, H, varargin )

  % hmmtrain assumes the system always starts in state 1, 
  % so we create a "state 1" that isn't used for anything else
  N = size(T,1);
  T = [ 0           ones(1,N)/N; ...
        zeros(N,1)  T ];
  M = size(H,2);
  H = [ zeros(1,M); H ];

  % train
  [ T, H ] = hmmtrain( y, T, H, varargin{:} );

  % remove false state 1
  T = T(2:end,2:end);
  H = H(2:end,:);

  end