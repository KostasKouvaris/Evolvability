function [ Attr ] = Attractors( Epochs, B, T, tau1, tau2 )
% Returns an array with the attractors' sizes

% Constants
No_Samples = 5000;

% Variables
M = size(B,2);
H = (2*(rand(No_Samples,M))-1)';

% Initialise
Attr = NaN(Epochs,1);

% Main
for i=Epochs:Epochs
    tempB = B;
    Pop = transpose(develop(H,tempB,T,tau1,tau2));
    Pop = sign(Pop);
    UdPop = unique(Pop,'rows')
    Attr(i,1) = size(UdPop,1);
end

end

