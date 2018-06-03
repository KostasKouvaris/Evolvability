% Hebbian learning for a given class

clear;

Test_Set = blockClass(4,1,2); 
Training_Set = [ 1  1  1  1 -1 -1 -1 -1
                -1 -1  1  1 -1 -1  1  1
                
                -1 -1  1  1  1  1 -1 -1
                 %1  1  1  1  1  1  1  1
                 ];
             
             Training_Set = [ 1  1  1  1 -1 -1 -1 -1
                 %1  1  1  1  1  1 -1 -1
                -1 -1  1  1  1  1 -1 -1
                 1  1  1  1  1  1  1  1
                 ]; 


N = size(Training_Set,1);
M = size(Training_Set,2);

%hinton(Training_Set'*Training_Set,max(max(abs(Training_Set'*Training_Set))));

H = (2*(net(sobolset(M),5000))-1)';
 
e = 0.1;
Steps = 400;
output_b = zeros(Steps, M^2);

T = 10;
tau1 = 1;
tau2 = 0.2;

f = figure; 
subplot_idx = 0;

for lambda = 0:0%0:0.01:1
    
    subplot_idx = subplot_idx + 1;
    
    %learning
    B = zeros(M); Bias = zeros(M,1);

    for i = 1:Steps
        B = B + Hebbian(Training_Set,e); %No Reg

    end

end

hinton(B,max(max(abs(B))));