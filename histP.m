function [ Hist_P, Accuracy ] = histP( Pop, Targets )
% Generate a histogram out of a population of phenotypes for a given set of targets

Targets = sign(Targets);
%Targets = [Targets; (-1)*Targets];

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

Hist_P = targetCounts;
sum(Hist_P);
end

