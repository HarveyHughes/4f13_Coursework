clear all, close all  
load('cw1e.mat')
%mesh(reshape(x(:,1),11,11),reshape(x(:,2),11,11),reshape(y,11,11));   

meanfunc = [];
covfunc1 = @covSEard;
covfunc2 = {@covSum, {@covSEard, @covSEard}};
covfunc3 = {@covSum, {@covSEard, @covSEard, @covSEard}};
covfunc4 = {@covSum, {@covSEard, @covSEard, @covSEard, @covSEard}};
covfunc5 = {@covSum, {@covSEard, @covSEard, @covSEard, @covSEard, @covSEard}};
covfunc6 = {@covSum, {@covSEard, @covSEard, @covSEard, @covSEard,@covSEard, @covSEard}};
covfunc7 = {@covSum, {@covSEard, @covSEard, @covSEard, @covSEard, @covSEard,@covSEard, @covSEard}};
covfunc8 = {@covSum, {@covSEard, @covSEard, @covSEard, @covSEard,@covSEard, @covSEard, @covSEard, @covSEard}};
covfunc9 = {@covSum, {@covSEard, @covSEard, @covSEard, @covSEard, @covSEard,@covSEard, @covSEard,@covSEard, @covSEard}};

likfunc = @likGauss;

% cov [log of length scale in dim 1,log of length scale in dim 2, log of signal std dev]
%lik [log of noise std dev]
hyp1 = struct('mean', [], 'cov', [-1 0 1], 'lik', 0);
hyp2 = struct('mean', [], 'cov', 0.1*randn(6,1), 'lik', 0);
hyp3 = struct('mean', [], 'cov', 0.1*randn(9,1), 'lik', 0);
hyp4 = struct('mean', [], 'cov', 0.1*randn(12,1), 'lik', 0);
hyp5 = struct('mean', [], 'cov', 0.1*randn(15,1), 'lik', 0);
hyp6 = struct('mean', [], 'cov', 0.1*randn(18,1), 'lik', 0);
hyp7 = struct('mean', [], 'cov', 0.1*randn(21,1), 'lik', 0);
hyp8 = struct('mean', [], 'cov', 0.1*randn(24,1), 'lik', 0);
hyp9 = struct('mean', [], 'cov', 0.1*randn(27,1), 'lik', 0);

hyp1min = minimize(hyp1, @gp, -300, @infGaussLik, meanfunc, covfunc1, likfunc, x, y)
hyp2min = minimize(hyp2, @gp, -300, @infGaussLik, meanfunc, covfunc2, likfunc, x, y)
hyp3min = minimize(hyp3, @gp, -300, @infGaussLik, meanfunc, covfunc3, likfunc, x, y)
hyp4min = minimize(hyp4, @gp, -300, @infGaussLik, meanfunc, covfunc4, likfunc, x, y)
hyp5min = minimize(hyp5, @gp, -300, @infGaussLik, meanfunc, covfunc5, likfunc, x, y)
hyp6min = minimize(hyp6, @gp, -300, @infGaussLik, meanfunc, covfunc6, likfunc, x, y)
hyp7min = minimize(hyp7, @gp, -300, @infGaussLik, meanfunc, covfunc7, likfunc, x, y)
hyp8min = minimize(hyp8, @gp, -300, @infGaussLik, meanfunc, covfunc8, likfunc, x, y)
hyp9min = minimize(hyp9, @gp, -300, @infGaussLik, meanfunc, covfunc9, likfunc, x, y)

nlml(1)=0;
nlml(1) = gp(hyp1min, @infGaussLik, meanfunc, covfunc1, likfunc, x, y);
nlml(2) = gp(hyp2min, @infGaussLik, meanfunc, covfunc2, likfunc, x, y);
nlml(3) = gp(hyp3min, @infGaussLik, meanfunc, covfunc3, likfunc, x, y);
nlml(4) = gp(hyp4min, @infGaussLik, meanfunc, covfunc4, likfunc, x, y);
nlml(5) = gp(hyp5min, @infGaussLik, meanfunc, covfunc5, likfunc, x, y);
nlml(6) = gp(hyp6min, @infGaussLik, meanfunc, covfunc6, likfunc, x, y);
nlml(7) = gp(hyp7min, @infGaussLik, meanfunc, covfunc7, likfunc, x, y);
nlml(8) = gp(hyp8min, @infGaussLik, meanfunc, covfunc8, likfunc, x, y);
nlml(9) = gp(hyp9min, @infGaussLik, meanfunc, covfunc9, likfunc, x, y);

plot(nlml);

count = 1;
xs(289,2)=0;
for d1 = -4:0.5:4 
    for d2 = -4:0.5:4 
        xs(count,1)=d1;
        xs(count,2)=d2;
        count = count +1;
    end
end

[mu1 s1] = gp(hyp1min, @infGaussLik, meanfunc, covfunc1, likfunc, x, y, xs);
[mu1 s2] = gp(hyp2min, @infGaussLik, meanfunc, covfunc2, likfunc, x, y, xs);
[mu1 s3] = gp(hyp3min, @infGaussLik, meanfunc, covfunc3, likfunc, x, y, xs);
[mu1 s4] = gp(hyp4min, @infGaussLik, meanfunc, covfunc4, likfunc, x, y, xs);
[mu1 s5] = gp(hyp5min, @infGaussLik, meanfunc, covfunc5, likfunc, x, y, xs);
[mu1 s6] = gp(hyp6min, @infGaussLik, meanfunc, covfunc6, likfunc, x, y, xs);
[mu1 s7] = gp(hyp7min, @infGaussLik, meanfunc, covfunc7, likfunc, x, y, xs);
[mu1 s8] = gp(hyp8min, @infGaussLik, meanfunc, covfunc8, likfunc, x, y, xs);
[mu1 s9] = gp(hyp9min, @infGaussLik, meanfunc, covfunc9, likfunc, x, y, xs);

sums(1)=0;
sums(1)=sum(s1);
sums(2)=sum(s2);
sums(3)=sum(s3);
sums(4)=sum(s4);
sums(5)=sum(s5);
sums(6)=sum(s6);
sums(7)=sum(s7);
sums(8)=sum(s8);
sums(9)=sum(s9);

figure(2);
plot(sums);