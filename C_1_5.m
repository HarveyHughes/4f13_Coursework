clear all, close all  
load('cw1e.mat')
%mesh(reshape(x(:,1),11,11),reshape(x(:,2),11,11),reshape(y,11,11));   

meanfunc = [];
covfunc1 = @covSEard;
covfunc2 = {@covSum, {@covSEard, @covSEard}};
likfunc = @likGauss;

% cov [log of length scale in dim 1,log of length scale in dim 2, log of signal std dev]
%lik [log of noise std dev]
hyp1 = struct('mean', [], 'cov', [-1 0 1], 'lik', 0);
hyp2 = struct('mean', [], 'cov', 0.1*randn(6,1), 'lik', 0);

hyp1min = minimize(hyp1, @gp, -100, @infGaussLik, meanfunc, covfunc1, likfunc, x, y)
hyp2min = minimize(hyp2, @gp, -100, @infGaussLik, meanfunc, covfunc2, likfunc, x, y)

nlml1 = gp(hyp1min, @infGaussLik, meanfunc, covfunc1, likfunc, x, y)
nlml2 = gp(hyp2min, @infGaussLik, meanfunc, covfunc2, likfunc, x, y)

count = 1;
xs(289,2)=0;
for d1 = -4:0.5:4 
    for d2 = -4:0.5:4 
        xs(count,1)=d1;
        xs(count,2)=d2;
        count = count +1;
    end
end

figure(1);
[mu1 s1] = gp(hyp1min, @infGaussLik, meanfunc, covfunc1, likfunc, x, y, xs);
mesh(reshape(xs(:,1),17,17),reshape(xs(:,2),17,17),reshape(mu1,17,17));
hold on;
scatter3(x(:,1),x(:,2), y, '+');
hold on;
surf(reshape(xs(:,1),17,17),reshape(xs(:,2),17,17),reshape(mu1+2*sqrt(s1),17,17),'FaceAlpha','0.1','EdgeColor' , 'none','FaceColor','k');
hold on;
surf(reshape(xs(:,1),17,17),reshape(xs(:,2),17,17),reshape(mu1-2*sqrt(s1),17,17),'FaceAlpha','0.1','EdgeColor' ,'none','FaceColor','k');

figure(2);
[mu2 s2] = gp(hyp2min, @infGaussLik, meanfunc, covfunc2, likfunc, x, y, xs);
mesh(reshape(xs(:,1),17,17),reshape(xs(:,2),17,17),reshape(mu2,17,17));
hold on;
scatter3(x(:,1),x(:,2), y, '+');
hold on;
surf(reshape(xs(:,1),17,17),reshape(xs(:,2),17,17),reshape(mu2+2*sqrt(s2),17,17),'FaceAlpha','0.1','EdgeColor' , 'none','FaceColor','k');
hold on;
surf(reshape(xs(:,1),17,17),reshape(xs(:,2),17,17),reshape(mu2-2*sqrt(s2),17,17),'FaceAlpha','0.1','EdgeColor' ,'none','FaceColor','k');

figure(3);
f = [mu1(137:153,:)+2*sqrt(s1(137:153,:)); flipdim(mu1(137:153,:)-2*sqrt(s1(137:153,:)),1)];
fill([xs(137:153,2); flipdim(xs(137:153,2),1)], f, [7 7 7]/8)
hold on; plot(xs(137:153,2), mu1(137:153),'color','r'); plot(x(56:66,2), y(56:66), '+', 'color','b')

figure(4);
f = [mu2(137:153,:)+2*sqrt(s2(137:153,:)); flipdim(mu2(137:153,:)-2*sqrt(s2(137:153,:)),1)];
fill([xs(137:153,2); flipdim(xs(137:153,2),1)], f, [7 7 7]/8)
hold on; plot(xs(137:153,2), mu2(137:153),'color','r'); plot(x(56:66,2), y(56:66), '+', 'color','b')

one_sum=sum(s1)
two_sum=sum(s2)
