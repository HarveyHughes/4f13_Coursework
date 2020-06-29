  load('cw1a.mat')
  xs = linspace(-3, 3, 361)';                  % 61 test inputs 
  
  meanfunc = [];                    % empty: don't use a mean function
  covfunc = @covPeriodic;              % periodic cov function
  likfunc = @likGauss;              % Gaussian likelihood
  
  % cov [log of length scale,period, log of signal std dev]
  %lik [log of noise std dev]
  hyp = struct('mean', [], 'cov', [-1 0.5 0 ], 'lik', 0);
  
  %[-1 0.5 0 0= nlml = 48.097 hyp2=[-0.7122 0.4067 -0.1559 -1.033]
  %larger feature size [-3 0.5 0 0] nlml = 6.6989 hyp2=-1.584 1.3851
  %-0.0722 -2.1523]
  hyp2 = minimize(hyp, @gp, -1000, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
  
  
  [mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);
  
  f = [mu+2*sqrt(s2); flipdim(mu-2*sqrt(s2),1)];
  fill([xs; flipdim(xs,1)], f, [7 7 7]/8)
  hold on; plot(xs, mu,'color','r'); plot(x, y, '+', 'color','b')