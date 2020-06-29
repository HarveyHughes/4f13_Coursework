  load('cw1a.mat')
  xs = linspace(-3, 3, 561)';                  % 61 test inputs 
  
  meanfunc = [];                    % empty: don't use a mean function
  covfunc = @covSEiso;              % Squared Exponental covariance function
  likfunc = @likGauss;              % Gaussian likelihood
  
  % cov [log of length scale, log of signal std dev]
  %lik [log of noise std dev]
  
  %try larger features but same noise 
  %hyp = struct('mean', [], 'cov', [4 0], 'lik', 0);
  
  %larger features and larger signal std (4,4,0) same result  (nlml =
  %78.2202)
  %increase noisea as well (1,4,2)
  %keep small feature size but larger noise (-1,1,1) same
  % (-1,0,1) same as initial start  (nlml = 11.899)
  %tiny feature sizes same noise
  %[-1,10,0] nlml = 78.337 hyp2= 24.2232, -0.2962, -0.4047]
  %[-3,3,-7] nlml = 57.96 hyp2= -3.639, -0.444, -1.952
  %[-1,0,-8] nlml = 23.4589 hyp2=-2.3334,-0.7131,-2.0266
  hyp = struct('mean', [], 'cov', [-1 0], 'lik', -8) 
  
  
  hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y)
  nlml = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y)
  
  [mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);
  
  f = [mu+2*sqrt(s2); flipdim(mu-2*sqrt(s2),1)];
  fill([xs; flipdim(xs,1)], f, [7 7 7]/8)
  hold on; plot(xs, mu,'color','r'); plot(x, y, '+', 'color','b')