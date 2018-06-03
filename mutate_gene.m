function [ G ] = mutate_gene( G )
%Apply single-point mutation on the genome

%Constants
%-------------------------------------------
%mr: mutation rate
mr = 1;
%mm: maximum magnitude of mutation
mm = 0.1;

if (rand()< mr)
    %select a trait uniformly at random
    r_idx = randi(length(G));

    %the amount of mutation is uniformly drawn at random in [-mm, mm]
    m = 2 * mm * rand() - mm;
    %m = 2 *(randi(2)-1) - 1;
    
    %apply mutation
    G(r_idx) = G(r_idx) + m;
    %G(r_idx) = m;
    
    %apply hard bounds; G(i) in [-1,1]
    G(r_idx) = min(max(G(r_idx),-1),1);
    %G(r_idx) = min(max(G(r_idx),0),1);
    
end
end

