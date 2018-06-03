function [ P ] = develop_v2( G, B, T, tau1, tau2 )
%Developmental process - Returns all states of development

%Input variables
%-----------------------------------------------------------
%G: embryonic phenotype
%P: adult phenotype
%B: interaction matrix
%T: number of developmental steps

%Constants
%-----------------------------------------------------------
%tau1: maximal expression rate of a given gene
%tau2: constant rate of degradation of a given gene product

P = G;  %initialise
F = (-Inf)*ones(size(G));

a = 0.3; %0.5; %0.5; %0.5; b = -0;

temp = [];

%temp = F;
% %steps = 0;
% for i=1:T
%     if (temp == P), break; end
%     temp = P;
%     P = (1-tau2)*P + tau1*tanh(B*P); 
%     %steps = steps + 1;
% end

% temp = F;
% steps = 0;
% while (P ~= temp)
%     temp = P;
%     P = (1-tau2)*P + tau1*tanh(B*P);
%     steps = steps + 1;
%     if (steps > T)
%         P = F;
%         break;
%     end
% end

%for i=1:T, P = tanh(P+tau2*(B*P)); end
%for i=1:T, P = tanh(a*((1-tau2)*P + tau1*(B*P))+b); end
% for i=1:T,
%     tempP = P;
%     %P =  tau1*tanh((1-tau2)*P + a*B*P);
%     %P = tanh((1-tau2)*P+tau1*a*(B*P));
%     %P = P - tau2 * P;
%     %P = tau1 * tanh(a*B*P);
%     %P = tanh(a*((1-tau2)*P + tau1*(B*P)));
%     P = (1-tau2) * P + tau1 * tanh(a*B*P);
%     %P(abs(P)>0.98) = 1;
%     if norm(tempP-P,2)<10^-12, return; end
% end
% %for i=1:T, P = sign((1-tau2)*P + tau1*(B*P)); end


% Th = 1;
% h = 1/Th;
% for i=1:T,
%     for j=1:Th
%         P = P + h*(- tau2*P + tau1* tanh(a * B*P - b));
%     end
% end


% M = size(B,1);
% %pr = 0.0005; %dropout 0.01; %0.033;
% 
% for i=1:T
%     %DropOut
%     %dMask = logical(rand(M,1)<pr);
%     %tempP = P;
%     %tempP(dMask)=0;
%     %P = (1-tau2) * tempP + tau1 * tanh(tau2*B*tempP)+a*tau2*B*tempP;
%     %DropConnect
%     dMask = logical(rand(M)<pr);
%     tempB = B;
%     tempB(dMask)=0;
%     P = (1-tau2) * P + tau1 * tanh(tau2*tempB*P)+a*tau2*tempB*P;
%     
%     
% end

% K = 5;
% temp = F;
% steps = 0;
% M = size(P,1);
% previousStates = NaN(M,K);
% Psi = Inf;
% while (max(P ~= temp) && ~(Psi < 1e-4 && ~isnan(Psi)))
%     temp = P;
%     P = (1-tau2)*P + tau1*tanh(B*P);
%     steps = steps + 1;
%     if (steps > T)
%         P = F;
%         break;
%     end
%     %calculate variance
%     Psi = sum(sum((previousStates-repmat(P,1,K)).^2,1))/(4*K*M);
%     previousStates = circshift(previousStates,[0 -1]);
%     previousStates(:,end) = P;
% end

% T
temp = [temp P];
for i=1:T
    P = tanh(a*B*P);
    temp = [temp P];
    %P = P .* (1 + normrnd(0,0.00008,size(P)));
end

%PathLength = steps;

P = temp;
%P(abs(P)>0.94) = sign(P(abs(P)>0.94));

end

