function [ Info ] = infoGain( output_b, T, tau1, tau2 )
% Determines the information gain over evolutionary time

No_Samples = 5000;

N = size(output_b,1);
M = size(output_b,2)^0.5;

H = (2*(net(sobolset(M),No_Samples))-1)';

Info = NaN(N,1);

for i=1:N-1
    
    i
    
    B1 = transpose(vec2mat(output_b(i,:),M));
    B2 = transpose(vec2mat(output_b(i+1,:),M));
    dTheta = norm(B1-B2,2);
    Pop1 = develop(H,B1,T,tau1,tau2);
    Pop2 = develop(H,B2,T,tau1,tau2);
    HC1 = histP(Pop1',blockClass(16,1,1))/No_Samples;
    HC2 = histP(Pop2',blockClass(16,1,1))/No_Samples;
    v1 = HC1.^0.5.*log(HC1);
    v1(isnan(v1)) = 0;
    v2 = HC1.^0.5.*log(HC2);
    v2(isnan(v2)) = 0;
    norm(v1-v2,2)
    Info(i,1) = norm(v1-v2,2);
end


end

