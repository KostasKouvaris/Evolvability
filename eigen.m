function [ E ] = eigen( OUT, T, tau1, tau2, Test_Set)
% Return the eigen values of the system over evolutionary time.

H = (2*(net(sobolset(16),20000))-1)';
E=[]; 
for i=1:size(OUT,1)
    i
    B=vec2mat(OUT(i,:),16);
    D = sign(develop(H,B,T,tau1,tau2));
    BI=cov(D');%/max(max(abs(cov(D'))));
%     if (det(BI)~=0)
%         K = [];
%         for j=1:size(Test_Set,1)
%             K = [K (Test_Set(j,:)*(BI)*Test_Set(j,:)')];
%         end
%         E = [E; K];
%     end
    %E = [E; eig(BI)'/sum(eig(BI)')];
    sum1 = []; sum2 = [];
    for i=1:4
        for j=((i-1)*4+2):(i)*4
            sum1 = [sum1 abs(BI((i-1)*4+1,j)) abs(BI(j,(i-1)*4+1))];
        end
    end
    for i=1:4
        for j=(i*4+1):16
            sum2 = [sum2 abs(BI((i-1)*4+1,j)) abs(BI(j,(i-1)*4+1))];
        end
    end    
    E = [E; [mean(sum1) mean(sum2)]];
end
end

