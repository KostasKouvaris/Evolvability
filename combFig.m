function [ OUTPUT ] = combFig( Test_Set, T, tau1, tau2 )
%COMBFIG Get errors for optimal models for each subset of the test set 

%Variables and Constants
No_Samples = 50000;
lr = 2;
lr_mod = 1.5;

Test_N = size(Test_Set,1);
Test_M = size(Test_Set,2);

sum_ = zeros(Test_N+1,1);
for i=2:Test_N+1, sum_(i) = sum_(i-1) + nchoosek(Test_N,i-1); end

%initialise
OUTPUT = NaN(sum_(end),4);
H = (2*(net(scramble(sobolset(Test_M,'Skip',0,'Leap',0),'MatousekAffineOwen'),No_Samples))-1)';
allCombinations = blockClass(Test_M,1,1);
allCombinations(allCombinations == -1) = 0;
dAll = sort(bi2de(allCombinations,'left-msb'),'ascend');

%calculate distribution for Test Set
Test_B = lr * Test_Set'*Test_Set/Test_N;
Test_D = develop(H,Test_B,T,tau1,tau2);
Test_Set = sign(Test_Set);
Test_Set(Test_Set == -1) = 0;
dTest = sort(bi2de(Test_Set,'left-msb'),'ascend');
idealHist_Test = hist(dTest,unique(dAll))/length(dTest);

%invert back
Test_Set(Test_Set == 0) = -1;
%Test_Set = Test_Set';


%Main
for i=1:Test_N,
    i
    tempComb = nchoosek(1:Test_N,i);
    n = size(tempComb,1);
    for j=1:n
        Training_Set = Test_Set(tempComb(j,:),:);
        B = lr_mod*Training_Set'*Training_Set/(i);
        
        D = develop(H,B,T,tau1,tau2);
        D = D';
        D = sign(D); %transpose and discretise
        D(D==-1)=0;
        dD = sort(bi2de(D,'left-msb'),'ascend');
        UdD = unique(dD);
        histD = histc(dD,UdD); %get the counts
        
        inTest = intersect(UdD,unique(dAll));
        
        targetCounts = zeros(size(unique(dAll)));
        targetCounts(ismember(unique(dAll),inTest)) = histD(ismember(UdD,inTest));
        
        targetHist = targetCounts'/length(dD); %normalise
        
        %calculate error
        tempVector =(( targetHist- idealHist_Test).^2)./(idealHist_Test);
        tempVector(isnan(tempVector))=0; tempVector(isinf(tempVector))=0;
        tempA = sum(tempVector);
        
        %after regularisation
        B(abs(B)<max(max(abs(B))))=0;
        
        D = develop(H,B,T,tau1,tau2);
        D = D';
        D = sign(D); %transpose and discretise
        D(D==-1)=0;
        dD = sort(bi2de(D,'left-msb'),'ascend');
        UdD = unique(dD);
        histD = histc(dD,UdD); %get the counts
        
        inTest = intersect(UdD,unique(dAll));
        
        targetCounts = zeros(size(unique(dAll)));
        targetCounts(ismember(unique(dAll),inTest)) = histD(ismember(UdD,inTest));
        
        targetHist = targetCounts'/length(dD); %normalise
        
        %calculate error
        tempVector =(( targetHist- idealHist_Test).^2)./(idealHist_Test); %/sum(idealHist_Training);
        tempVector(isnan(tempVector))=0; tempVector(isinf(tempVector))=0;
        tempE = sum(tempVector);
        
        OUTPUT(sum_(i)+j,:) = [i j tempA tempE];
    end
end


