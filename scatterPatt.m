function [ X, Y ] = scatterPatt( Pop, m)
%2DPLOT Summary of this function goes here
%   Detailed explanation goes here

%Pop = sign(Pop);
X = ones(size(Pop,1),1);
Y = ones(size(Pop,1),1);

S1 = ones(size(Pop,2),1);
S2 = -S1;

for i=1:size(Pop,1) %for each individual
%     tempPattern = vec2mat(Pop(i,:),m);
%     %countBlacks
%     total_black_sum = 0;
%     for j=1:size(tempPattern,1) %for each row
%         if (tempPattern(j,1)==-1), num = 1; else num = 0; end
%         sum = num;
%         for k = 2:m
%             if (tempPattern(j,k) == -1)
%                 if (tempPattern(j,k-1) == -1)
%                     num = num + 1;
%                 else
%                     num = 1;
%                 end
%             else
%                 num  = 0;
%             end
%             sum = sum + num;
%         end
%         total_black_sum = total_black_sum + sum;
%     end
%     
%     %countWhites
%     total_white_sum = 0;
%     for j=1:size(tempPattern,1) %for each row
%         if (tempPattern(j,1)== 1), num = 1; else num = 0; end
%         sum = num;
%         for k = 2:m
%             if (tempPattern(j,k) == 1)
%                 if (tempPattern(j,k-1) == 1)
%                     num = num + 1;
%                 else
%                     num = 1;
%                 end
%             else
%                 num  = 0;
%             end
%             sum = sum + num;
%         end
%         total_white_sum = total_white_sum + sum;
%     end
%     X(i,1) = total_black_sum;
%     Y(i,1) = total_white_sum;

    D1 = norm(Pop(i,:)' - S1, 2)^2;
    D2 = norm(Pop(i,:)' - S2, 2)^2;
    
    X(i,1) = D1;
    Y(i,1) = D2;
    
end
end

