function [Ideal_histD_Training, histD, Ideal_histD_Test] = showHist2( outB, T, tau1, tau2, Training_Set, Test_Set )

lr = 1; %learning rate

No_Samples = 50000; %8*50000;
Ignore = 0;

N = size(outB,1);
M = size(outB,2)^.5;
            
%generate random samples from genotype space
HI = 1*(2*(net(scramble(sobolset(M,'Skip',0,'Leap',0),'MatousekAffineOwen'),No_Samples+Ignore))-1)';
%H = H(:,Ignore+1:(No_Samples + Ignore));

%HI = (2*(rand(No_Samples,M))-1)';

allCombinations = blockClass(M,1,1);


dall = allCombinations;
dall(dall==-1)=0;
dall = unique(bi2de(dall,'left-msb'));
Targets = sign(Test_Set);
Targets(Targets == -1) = 0;
dTargets = unique(bi2de(Targets,'left-msb')); % Convert to decimals.
dMask = ismember(dall,dTargets); 

%HH = (histP((H)',allCombinations)/No_Samples);

% figure;
% bar(find(~dMask), HH(~dMask),'g'); hold on;
% bar(find(dMask), HH(dMask),'r');axis square;

%ideal distribution for Training_Set
Ideal_B = Hebbian (Training_Set, lr);
Ideal_D = develop(HI,Ideal_B,T,tau1,tau2); %generate ideal phenotypic variants
Ideal_histD_Training = histP(Ideal_D',Test_Set)/No_Samples;

aIdeal_histD_Training = histP(Ideal_D',allCombinations)/No_Samples;
%hinton(Ideal_B, max(max(abs(Ideal_B))));

%ideal distribution for Test_Set
Ideal_B = Hebbian (Test_Set, lr);
Ideal_D = develop(HI,Ideal_B,T,tau1,tau2); %generate ideal phenotypic variants
Ideal_histD_Test = histP(Ideal_D',Test_Set)/No_Samples;

aIdeal_histD_Test = histP(Ideal_D',allCombinations)/No_Samples;



%actual distribution
B = transpose(vec2mat(outB(end,:),M));
D = (develop(HI,B,T,tau1,tau2)); %generate phenotypic variants
tempD = D';



tempD(abs(tempD)<0*max(max(abs(D))))=0;

D = sign(tempD');

D(:,~all(D,1))=[];

% train_ = [];
% for i=1:size(Training_Set,1)
% idx = find(ismember(tempD,Training_Set(i,:),'rows'));
% diffs =abs(H(:,idx)-repmat(Training_Set(i,:)',1,size(H(:,idx),2))).^2;
% train_ = [train_ mean(sum(diffs).^.5)]; 
% end
% mean(train_)
% 
% test_ = [];
% for i=1:size(Test_Set,1)
% idx = find(ismember(tempD,Test_Set(i,:),'rows'));
% diffs =abs(H(:,idx)-repmat(Test_Set(i,:)',1,size(H(:,idx),2))).^2;
% test_ = [test_ mean(sum(diffs).^.5)]; 
% end
% test_(isnan(test_))=0;
% mean(test_)



%tempD = unique(tempD,'rows');
uPatterns = size(tempD,1);

% Diffs = [];
% for i=1:size(Test_Set,1)
%     Diffs = [Diffs sum(tempD == repmat(Test_Set(i,:),uPatterns,1),2)];
% end
% 
% Test_Hist = histc(min(Diffs'),0:15)/No_Samples;

% figure; bar(0:15,histc(min(Diffs'),0:15)/No_Samples,'g'); axis square; xlabel('Phenotypic Distance'); ylabel('Relative Counts');
% xlim([-1 15]); ylim([0 1]); hold on;

% Diffs = [];
% Training_Set = unique([Training_Set; (-1)*Training_Set],'rows');
% for i=1:size(Training_Set,1)
%     Diffs = [Diffs sum(tempD == repmat(Training_Set(i,:),uPatterns,1),2)];
% end
% 
% figure; bar(0:15,histc(min(Diffs'),0:15)/No_Samples)

% Diffs = [];
% for i=1:size(Test_Set,1)
%     Diffs = [Diffs sum(sign(H)' == repmat(Test_Set(i,:),No_Samples,1),2)];
% end
% H_Hist = histc(min(Diffs'),0:15)/No_Samples;
% 
% figure; 
% bar(0:15,[[1; zeros(15,1)] Test_Hist' H_Hist']); axis square; xlabel('Phenotypic Distance'); ylabel('Relative Counts');
% xlim([-1 9]); ylim([0 1]); legend('Without Reg','With L2 Reg','Unstructured');
% 
 histD = histP(D',Test_Set)/length(D); %No_Samples;
% 

% D(D==-1)=0;
% dD = sort(bi2de(D','left-msb'),'ascend');
% UdD = unique(dD); 
% temp = histc(dD,UdD); %get the counts
 temp = histP(D',allCombinations)/length(D); %No_Samples;
ahistD = histP(D',allCombinations)/No_Samples;

%sum(temp)

%hinton(Ideal_B, max(max(abs(Ideal_B))));

figure;
% subplot(1,3,1);
%bar(find(~dMask), aIdeal_histD_Training(~dMask),'g'); hold on;
%bar(find(dMask), aIdeal_histD_Training(dMask),'r');
% axis square;
% subplot(1,3,2);
bar(find(~dMask), ahistD(~dMask),'g'); hold on;
bar(find(dMask), ahistD(dMask),'r');
% sum(ahistD)
%axis square;
% subplot(1,3,3);
%bar(find(~dMask), aIdeal_histD_Test(~dMask),'g'); hold on;
%bar(find(dMask), aIdeal_histD_Test(dMask),'r');axis square;

%bar(temp)

histD = temp;

end