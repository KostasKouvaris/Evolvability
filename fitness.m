function [ A ] = fitness( P, S, B, lambda,O)
% Fitness estimated on the adult phenotype

%load('Training_Set_Experiment_1a');
%S = S + normrnd(0,0.000002,1,length(S));
L = length(P);
M = max(abs(S));
R = 0;
if isinf(max(P))
    E = 0;
%elseif (norm(sign(P)-sign(S'),1)~=0)
%    E = 0;
else
    E = 0.5*(1 + dot(P,S)/(L*M));
end
%E = dot(P,S);
%E = -norm(P-S',2);
%P = sign(P);
%E = -norm(P-S',1);
%E = dot(P,S);
%R = norm(B(:),1); %L1-norm
%R = (sum(abs(B(:)).^.5)); %norm(B(:),2)^2;

%R = (sum(B(:).^2)); %norm(B(:),2)^2; %L2-norm
%R2 = norm(B(:),2)^2; %L2-norm

if (O==1)
    A = E;
elseif (O==0)
    A = -R;
else
    A = E - (lambda /(L^2)) * R - (30 /(L^2))*R2;
end

%A = E - lambda * R;

end

