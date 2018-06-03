function [ B ] = mutate_weights_v2( B )
%Apply single-point mutation on the interaction matrix B
l = length(B);

%Constants
%-------------------------------------------
%mr: mutation rate
mr = 1;
%mm: maximum magnitude of mutation
mm = 1/150; %1/150; %works with 1/150000;

if (rand()< mr)
    %the amount of mutation is uniformly drawn at random in [-mm, mm]
    m = 2 * mm * rand(l) - mm;
    
    %apply mutation
    B = B + m/(l^2);

end
end

