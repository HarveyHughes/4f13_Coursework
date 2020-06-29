  meanfunc = {[]}; hyp.mean = [];
  covfunc = {@covProd, {@covPeriodic, @covSEiso}}; hyp.cov = [-0.5 0 0 2 0];
  likfunc = @likGauss; hyp.lik = 0;
 
  x= linspace(-5,5,200)';
  K = feval(covfunc{:}, hyp.cov, x);
  %mu = feval(meanfunc{:}, hyp.mean, x);
  u=eig(K+1e-6*eye(200))
  for i = 1:25
    x2 = gpml_randn(2, 200, 1);
    y = chol(K+1e-6*eye(200))'*x2 ;% + mu;%no noise + exp(hyp.lik)*gpml_randn(0.2, n, 1);
    plot(x, y)
    hold on
  end
  


