function [ ] = genFigEvol( )
% Box plot to show the rate of adaptation for each scenario

L2_Reg = [];
L1_Reg = [];
Jit_Reg = [];
No_Reg = [];

M = 1:8;

for i=M
    load(['myData\EvFit\Discr_L1_Reg_v2_Env_' num2str(i)])
    L1_Reg = [L1_Reg mean(st,2)];
    load(['myData\EvFit\Discr_L2_Reg_v2_Env_' num2str(i)])
    L2_Reg = [L2_Reg mean(st,2)];
    load(['myData\EvFit\Discr_No_Reg_v2_Env_' num2str(i)])
    No_Reg = [No_Reg mean(st,2)];
    load(['myData\EvFit\Discr_Jit_v2_Env_' num2str(i)])
    Jit_Reg = [Jit_Reg mean(st,2)];
end

threshold = 1;

[~, L1_Reg] = max([L1_Reg; zeros(0,length(M)); ones(1,length(M)*1)] >= threshold); 
[~, L2_Reg] = max([L2_Reg; zeros(0,length(M)); ones(1,length(M)*1)] >= threshold);
[~, No_Reg] = max([No_Reg; zeros(0,length(M)); ones(1,length(M)*1)] >= threshold); 
[~, Jit_Reg] = max([Jit_Reg; zeros(0,length(M)); ones(1,length(M)*1)] >= threshold);

%[No_Reg' Jit_Reg' L2_Reg'  L1_Reg' ]

figure; boxplot([No_Reg' Jit_Reg' L2_Reg'  L1_Reg' ],'labels',{'No Reg','Jittering','L2 Reg','L1 Reg'}); set(gca,'FontSize',11); set(findobj(gca,'Type','text'),'FontSize',12); axis square; ylim([0 3000]);
%figure; hold on; plot(mean(L2_Reg,2),'b'); plot(mean(L1_Reg,2),'g'); plot(mean(No_Reg,2),'r'); plot(mean(Jit_Reg,2),'k'); 
%legend('L2 Reg','L1 Reg','No Reg','Jittering');
%xlabel('Evolutionary Time');
title('Rate of Adaptation','FontSize',12);
ylabel('Generations to adapt','FontSize',12);

end

