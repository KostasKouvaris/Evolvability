function [ Test_Set ] = RNA( M )
%RNA Return a class of RNA-like phenotypes


%M - number of modules

load('DoubleLoop'); %variable name PP

Left = -PP';
Right = -fliplr(PP');
Top = -PP;
Down = -flipud(PP);

Combinations = de2bi(0:(2^M)-1,'left-msb'); %all possible combinations of modules

sizeM = size(PP,1)*size(PP,2); %size of each module

Test_Set = zeros(size(Combinations,1),M*sizeM);

for i=1:size(Combinations,1)
    if (Combinations(i,1)==1), Test_Set(i,1:sizeM) = Left(:)'; else  Test_Set(i,1:sizeM) = 1; end
    if (Combinations(i,2)==1), Test_Set(i,sizeM+1:2*sizeM) = Top(:)'; else  Test_Set(i,sizeM+1:2*sizeM) = 1; end 
    if (Combinations(i,3)==1), Test_Set(i,2*sizeM+1:3*sizeM) = Right(:)'; else  Test_Set(i,2*sizeM+1:3*sizeM) = 1; end 
    if (Combinations(i,4)==1), Test_Set(i,3*sizeM+1:end) = Down(:)'; else  Test_Set(i,3*sizeM+1:end) = 1; end 
end


end

