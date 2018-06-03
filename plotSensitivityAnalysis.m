function [  ] = genFigure2(T,tau1,tau2,Training_Set,Test_Set)
% Plot results from sensitivity analysis

%L1
%lambda = [0.001 0.005 0.01 0.05 1:11 13]

%L2
lambda = [1 5 10 20 40 80 160 320 640 960 1100 1150 1200 1280 1300 1350 1400];

%J
%lambda = 100*[ 0.000005:0.000005:0.0001 0.0002 0.0003 0.00036 0.0004:0.0001:0.001]

a = zeros(size(lambda));
b = zeros(size(lambda));

length(lambda)
for i=1:length(lambda)
    temp = strsplit(num2str(lambda(i)),'.');
    load(['C:\Users\User\Documents\MATLAB\Overfitting_3\myData\10_2_v2\L2_' num2str(lambda(i)) '.mat']);
    %load(['C:\Users\User\Documents\MATLAB\Overfitting_3\myData\10_0.2_v2_300_2000\J_0.00' temp{2} '.mat']);
    %B = vec2mat(OUT(end,:),16);
    [a(i),b(i)] = findErrors_v2(OUT(end,:),T,tau1,tau2,Training_Set,Test_Set);
end

%L1
%a = [a a(end)*ones(1,4)];
%b = [b b(end)*ones(1,4)];
%lambda = [lambda 14:17]/32;

%L2
lambda = (lambda/32);

%Jit
%lambda = lambda/100;

figure;
plot(lambda,a,'go-');
hold on;
plot(lambda,b,'ro-');

axis square;
ylim([-0.1 1.4000000001]);
set(gca,'FontSize',11);

xlabel('Regularisation Parameter','FontSize',12);
ylabel('Chi-squared Error','FontSize',12);
legend('Training Error', 'Test Error');

%L1
%xlim([-0.1 0.6]);
%title('Sparse Connectivity (L1 Reg)','FontSize',12);

%L2
xlim([-5 50]);
title('Weak Connectivity (L2 Reg)','FontSize',12);

%Jit
%xlim([-0.00015 0.0012]);
%title('Noisy Environments (Jittering)','FontSize',12);
%xlabel('Level of Noise','FontSize',12);


end

