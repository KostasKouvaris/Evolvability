function [ output_args ] = plotDevelopment( G, B, tau1, tau2, T )
% Plot developmental trajectories

p_size = size(B,1);

a=0.2;
h=0.5;
% %Development
output_d = zeros(1*(T+1), p_size);
%G = 2*rand(p_size,1)-1;
for i=1:1
    P = G+normrnd(0,2,size(G));
    sign(P')
    output_d(1+(i-1)*(T+1),:) = P;
    for j=1:T
        if i==1,P = (1-tau2) * P + tau1 * tanh(B*P + a*G); end
        %if i==2,P = P + h * (tau1 * B * tanh(P) - tau2 * P); end
        %if i==3,P = P + h * (tau1 * B * tanh(P)./sum(B,1)' - tau2 * P); end
        %if i==4,P = P + h * (tau1 * tanh(B * P) - tau2 * P); end
        output_d((T+1)*(i-1)+j+1,:) = P;
    end
    sign(P')
end
figure; plot(1:T+1,output_d(1:T+1,:)); hold on; 
%plot(T+1+1:2*(T+1),output_d(T+1+1:2*(T+1),:)); 
%plot(2*(T+1)+1:3*(T+1),output_d(2*(T+1)+1:3*(T+1),:)); 
%plot(3*(T+1)+1:4*(T+1),output_d(3*(T+1)+1:4*(T+1),:)); hold off;
set(gca,'XTick',1:T+1:4*(T+1),'XTickLabel',['tr.1';'tr.2';'tr.3';'tr.4']); xlabel('Developmental timesteps for each trajectory'); ylabel('Gene expression levels');

end

