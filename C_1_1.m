  load('cw1a.mat')
  xs = linspace(-3, 3, 361)';                  % 61 test inputs 
  
  meanfunc = [];                    % empty: don't use a mean function
  covfunc = @covSEiso;              % Squared Exponental covariance function
  likfunc = @likGauss;              % Gaussian likelihood
  
  
  hyp = struct('mean', [], 'cov', [-1 0], 'lik', 0);
  
  hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
  
  
  [mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);
  
  f = [mu+2*sqrt(s2); flipdim(mu-2*sqrt(s2),1)];
  fill([xs; flipdim(xs,1)], f, [7 7 7]/8)
  hold on; plot(xs, mu,'color','r'); plot(x, y, '+', 'color','b')