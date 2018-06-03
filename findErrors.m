function [ Training_Error, Test_Error ] = findErrors( outB, T, tau1, tau2, Training_Set, Test_Set )

lr = 2; %1.5; %learning rate

No_ErrorTypes = 1;
%ErrorTypes_Labels ={'Hellinger','Diff','Chi','aHellinger','aDiff','aChi'};
ErrorTypes_Labels ={'Chi Square Distance'};


No_Samples = 5000;

N = size(outB,1);
M = size(outB,2)^.5;
            
%generate random samples from genotype space
H = (2*(net(scramble(sobolset(M,'Skip',500,'Leap',0),'MatousekAffineOwen'),No_Samples))-1)';
%H = (2*(net(sobolset(M),No_Samples))-1)';
allCombinations = blockClass(M,1,1);

%ideal distribution for Training_Set
Ideal_B = Hebbian (Training_Set, lr);
Ideal_D = develop(H,Ideal_B,T,tau1,tau2); %generate ideal phenotypic variants
aIdeal_histD_Training = histP(Ideal_D',allCombinations)/No_Samples;
Ideal_histD_Training = histP(Ideal_D',Training_Set)/No_Samples;
D_Training = Ideal_D;

%ideal distribution for Test_Set
Ideal_B = Hebbian (Test_Set, lr);
Ideal_D = develop(H,Ideal_B,T,tau1,tau2); %generate ideal phenotypic variants
aIdeal_histD_Test = histP(Ideal_D',allCombinations)/No_Samples;
Ideal_histD_Test = histP(Ideal_D',Test_Set)/No_Samples;
D_Test = Ideal_D;

%Initialise
Test_Error = zeros(N,No_ErrorTypes);
Training_Error = zeros(N,No_ErrorTypes);

for i = 1:N
    i;
    B = vec2mat(outB(i,:),M);
    Test_Error(i,:) = HD(H, B, Test_Set, tau1, tau2, T, Ideal_histD_Test, aIdeal_histD_Test);
    Training_Error(i,:) = HD(H, B, Training_Set, tau1, tau2, T, Ideal_histD_Training,aIdeal_histD_Training);
end

% %plot errors
% figure; 
% for k = 1:No_ErrorTypes
%     subplot(2,3,k);
%     %subplot(1,2,k);
%     plot(Training_Error(:,k),'--.g'); hold on; plot(Test_Error(:,k),'--.r'); hold off;
%     axis square;
%     %legend('Training Error','Generalisation Error'); 
%     xlabel('Epochs'); ylabel('Error');
%     title(ErrorTypes_Labels(k));
% end

end

