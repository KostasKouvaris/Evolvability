function [ B ] = mutate_biases( B )
%Apply single-point mutation on the interaction matrix B
l = size(B,1);

%Constants
%-------------------------------------------
%mr: mutation rate
mr = 1;
%mm: maximum magnitude of mutation
mm = 1/15000;

if (rand()< mr)
    %the amount of mutation is uniformly drawn at random in [-mm, mm]
    m = 2 * mm * rand(l,1) - mm;
    
    %apply mutation
    B = B + m/(l^2);

end
end

