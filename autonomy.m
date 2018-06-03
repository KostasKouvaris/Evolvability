function [ A ] = autonomy( b, OUT, T, tau1, tau2, Training_Set, Test_Set )

% Calculate the autonomy of a given system

% Initialise
HI = 1*(2*(net(scramble(sobolset(16,'Skip',0,'Leap',0),'MatousekAffineOwen'),5000))-1)';
A=[];

% Main
for i=1:size(OUT,1)
    D = sign(develop(HI,vec2mat(OUT(i,:),16),T,tau1,tau2));
    G=cov(D');  G = G/norm(G);
    sum=0;
    for k=1:8      
           b = Training_Set(k,:); 
           e = b*G*b'/(norm(b)^2);
           %eg = eig(G,'nobalance');
           %c = (b*(G^-1)*b'/(norm(b)^2));
           % A(i,1) = A(i,1)+ max(eg/sum(eg));
           eg = e;
           sum=sum+eg;
    end
    A = [A sum];
end

end

