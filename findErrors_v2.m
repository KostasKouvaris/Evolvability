function [Training_Error, Test_Error, idealHist_Training, idealHist_Test, targetHist] = findErrors_v4( output_b, H, T, tau1, tau2, Training_Set, Test_Set )


lr = 1;

%Get size
Training_N = size(Training_Set,1);
Training_M = size(Training_Set,2);
Test_N = size(Test_Set,1);
Test_M = size(Test_Set,2);
N = size(output_b,1); %epochs
M = size(output_b,2).^.5; %genome's size

allCombinations = blockClass(M,1,1);

%Variables and Constants
No_Samples = 5000;

%Initialise
Test_Error = NaN(N,1);
Training_Error = NaN(N,1);

%generate random samples from genotype space
H = (2*(net(scramble(sobolset(M,'Skip',0,'Leap',0),'MatousekAffineOwen'),No_Samples))-1)';

Training_Set = develop(H,lr*Training_Set'*Training_Set/Training_N,T,tau1,tau2);
Test_Set = develop(H,lr*Test_Set'*Test_Set/Test_N,T,tau1,tau2);

theta = 0;
%Convert to decimals
Training_Set = sign(Training_Set'-theta);
Test_Set = sign(Test_Set'-theta);

allCombinations(allCombinations == -1) = 0;
Training_Set(Training_Set == -1) = 0;
Test_Set(Test_Set == -1) = 0;

dAll = sort(bi2de(allCombinations,'left-msb'),'ascend');
dTraining = sort(bi2de(Training_Set,'left-msb'),'ascend'); 
dTest = sort(bi2de(Test_Set,'left-msb'),'ascend');

idealHist_Training = hist(dTraining,unique(dAll))/length(dTraining);
idealHist_Test = hist(dTest,unique(dAll))/length(dTest);

%Main loop
for i=1:N
    i
    B = transpose(vec2mat(output_b(i,:),M)); %get interaction matrix; vector to matrix
    D = develop(H,B,T,tau1,tau2); %generate phenotypic variants
    D = D';

    %hinton(BI,max(max(abs(BI))));
    D = sign(D); %transpose and discretise

    D(D==-1)=0;
    dD = sort(bi2de(D,'left-msb'),'ascend');
    UdD = unique(dD); 
    histD = histc(dD,UdD); %get the counts
    
    %inTest = intersect(UdD,unique(dTest));
    inTest = intersect(UdD,unique(dAll));
    
    targetCounts = zeros(size(unique(dAll)));
    targetCounts(ismember(unique(dAll),inTest)) = histD(ismember(UdD,inTest));
    
    targetHist = targetCounts'/length(dD); %normalise
    
    %calculate error
    tempVector =(( targetHist- idealHist_Training).^2)./(idealHist_Training); %/sum(idealHist_Training);
    tempVector(isnan(tempVector))=0; tempVector(isinf(tempVector))=0;
    Training_Error(i,1) = sum(tempVector);
    tempVector =(( targetHist- idealHist_Test).^2)./(idealHist_Test); %/sum(idealHist_Training);
    tempVector(isnan(tempVector))=0; tempVector(isinf(tempVector))=0;
    Test_Error(i,1) = sum(tempVector);

end


%figure; bar(targetHist);
%figure; bar(idealHist_Training);
%figure; bar(idealHist_Training)
%figure; bar(idealHist_Test)

end

