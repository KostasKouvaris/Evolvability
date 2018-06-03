function [histD] = showHist( outB, T, tau1, tau2, Training_Set, Test_Set )

lr = 1; %learning rate

No_Samples = 50000;

N = size(outB,1);
M = size(outB,2)^.5;
            
%generate random samples from genotype space
H = 10*(2*(net(sobolset(M),No_Samples))-1)';

allCombinations = blockClass(M,1,1);
%H = (2*(rand(No_Samples,M))-1)';
figure; HH = histP(H',allCombinations)/No_Samples; bar(HH);

%allCombinations = blockClass(M,1,1);


%ideal distribution for Training_Set
Ideal_B = Hebbian (Training_Set, lr);
Ideal_D = develop(H,Ideal_B,T,tau1,tau2); %generate ideal phenotypic variants
Ideal_histD_Training = histP(Ideal_D',Test_Set)/No_Samples;

%hinton(Ideal_B, max(max(abs(Ideal_B))));

%ideal distribution for Test_Set
Ideal_B = Hebbian (Test_Set, lr);
Ideal_D = develop(H,Ideal_B,T,tau1,tau2); %generate ideal phenotypic variants
Ideal_histD_Test = histP(Ideal_D',Test_Set)/No_Samples;

%actual distribution
B = transpose(vec2mat(outB(end,:),M));
%hinton(B,max(max(abs(B))));
D = develop(H,B,T,tau1,tau2); %generate phenotypic variants
histD = histP(D',Test_Set)/No_Samples;
    

%hinton(Ideal_B, max(max(abs(Ideal_B))));

figure;
% subplot(1,3,1);
% bar(Ideal_histD_Training);
% axis square;
% subplot(1,3,2);
bar(histD);
sum(histD)
axis square;
% subplot(1,3,3);
% bar(Ideal_histD_Test);
% axis square;
    
end