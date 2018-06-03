function [ B ] = mutate_weights( B )
%Apply single-point mutation on the interaction matrix B
l = length(B);

%Constants
%-------------------------------------------
%mr: mutation rate
mr = 1;
%mm: maximum magnitude of mutation
mm = 1/1500; %2/1500; %1/150;
   
if (rand()< mr)
    %select a trait uniformly at random
    r_idx = randi(l^2);

    %the amount of mutation is uniformly drawn at random in [-mm, mm]
    m = 2 * mm * rand() - mm;
    %m = mm*(2*(randi(2)-1) - 1);
    
    %apply mutation
    x1 = ceil(r_idx/l);
    x2 = mod(r_idx,l)+1;
    B(x1,x2) = B(x1,x2) + m;
end


%B(logical(eye(size(B))))=0;

end

