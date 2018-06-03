function [ Error ] = HD( H, B, Actual_TS, tau1, tau2, T, Ideal_histD, aIdeal_histD )
%HD calculates the Hellinger Distance (HD) between the generated phenotypic
%distribution over H, based on B, tau1, tau2 and T, and the ideal
%phenotypic distribution determined by the given set Actual_TS and a scalar
%e 

N = size(H,2);
M = size(H,1);

D = develop(H,B,T,tau1,tau2); %generate phenotypic variants

allCombinations = blockClass(M,1,1);
ahistD = histP(D',allCombinations)/N;

histD = histP(D',Actual_TS)/N;

%aHEL = ((0.5^0.5)*(sum((histD.^0.5-Ideal_histD.^0.5).^2))^0.5)/length(histD); %Hellinger
%aHEL = (0.5^0.5)*(sum((ahistD.^0.5-aIdeal_histD.^0.5).^2))^0.5;

aDIFF = sum(( histD- Ideal_histD).^2);
%aDIFF = sum((ahistD-aIdeal_histD).^2);
%aDIFF = pdist([ahistD'; aIdeal_histD'],'euclidean');
%aDIFF = norm(ahistD-aIdeal_histD,2);

% Chi = sum((( histD- Ideal_histD).^2)./(Ideal_histD+histD));
% aChi = sum(((ahistD-aIdeal_histD).^2)./(aIdeal_histD+ahistD));

tempVector =(( ahistD - aIdeal_histD).^2)./(aIdeal_histD); %/sum(idealHist_Training);
tempVector(isnan(tempVector))=0; tempVector(isinf(tempVector))=0;
aChi = sum(tempVector);

% tempVector =(( histD - Ideal_histD).^2); %./(Ideal_histD); %/sum(idealHist_Training);
% tempVector(isnan(tempVector))=0; tempVector(isinf(tempVector))=0;
% Chi = sum(tempVector);



% aKL = log(ahistD./aIdeal_histD).*ahistD;
% aKL(isnan(aKL))=0;
% aKL(isinf(aKL))=0;
% aKL = sum(aKL);



%Error = [HEL DIFF Chi aHEL aDIFF aChi];

Error = aChi;
%Error = aDIFF;
%Error = aHEL;
end

