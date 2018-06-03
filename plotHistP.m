function [ Hist_P, Accuracy ] = plotHistP( B, T, tau1, tau2, No, Targets )
%HISTP Generate and plot a histogram of phenotypes produced by a given developmental system.

%all possible combinations
Targets = blockClass(8,1,1);

M = length(B);

H = (2*(rand(No,M))-1)';


Pop = develop(H,B,T,tau1,tau2); 
Pop = Pop';

Pop = sign(Pop);

Pop(Pop == -1) = 0;
Targets(Targets == -1) = 0;

dPop = bi2de(Pop,'left-msb'); % Convert to decimals.
dTargets = unique(bi2de(Targets,'left-msb')); % Convert to decimals.

UdPop = unique(dPop);

theCounts = histc(dPop,UdPop); % Count occurrences of each decimal number. The ith number corresponds to the ith unique element returned by unique(bD)
IS = intersect(UdPop,dTargets);

bMask1 = ismember(UdPop,IS); % Check which members of dA are also members of dTargets.
bMask2 = ismember(dTargets,IS); % Check which members of dA are also members of dTargets.

targetCounts = zeros(size(dTargets));
targetCounts(bMask2) = theCounts(bMask1);

Accuracy = sum(theCounts)*100/size(Pop,1);

figure;

Hist_P = targetCounts;
bar(Hist_P,'FaceColor','b');

Hist_P
% dTargets = num2str(de2bi(dTargets,'left-msb'));
% str = mat2cell(dTargets,ones(1,size(dTargets,1)),size(dTargets,2));
% set(gca, 'XTickLabel',str, 'XTick',1:numel(str));
% rotateXLabels( gca(), 90);


end

