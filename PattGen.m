function [ Test_Set ] = PattGen( M )
% Generates RNA patterns


%M - number of modules

load('Pattern_1'); %variable name PP
load('Pattern_2'); %variable name PD

%PD=[-1 -1 -1; 1 1 1; -1 1 -1; -1 -1 -1];
%PD=ones(4,3);

Left1 = -PD';
Right1 = -fliplr(PD');
Top1 = -PD;
Down1 = -flipud(PD);

Left2 = -PS';
Right2 = -fliplr(PS');
Top2 = -PS;
Down2 = -flipud(PS);


Combinations = de2bi(0:(2^M)-1,'left-msb'); %all possible combinations of modules

sizeM = size(PD,1)*size(PD,2); %size of each module

Test_Set = zeros(size(Combinations,1),M*sizeM);

for i=1:size(Combinations,1)
    if (Combinations(i,1)==1), Test_Set(i,1:sizeM) = Left1(:)'; else  Test_Set(i,1:sizeM) = Left2(:)'; end
    if (Combinations(i,2)==1), Test_Set(i,sizeM+1:2*sizeM) = Top1(:)'; else  Test_Set(i,sizeM+1:2*sizeM) = Top2(:)'; end 
    if (Combinations(i,3)==1), Test_Set(i,2*sizeM+1:3*sizeM) = Right1(:)'; else  Test_Set(i,2*sizeM+1:3*sizeM) = Right2(:)'; end 
    if (Combinations(i,4)==1), Test_Set(i,3*sizeM+1:end) = Down1(:)'; else  Test_Set(i,3*sizeM+1:end) = Down2(:)'; end 
end


end

