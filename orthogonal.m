function [ Training_Set ] = orthogonal( Test_Set, No )
% Checks pairwise pattern orthogonality

found = 0;

while(found == 0)
   perms = randperm(size(Test_Set,1));
   r_idex = perms(1:No);
   Training_Set = Test_Set(r_idex,:);
   found = 1;
   for i=1:No
       for j=i+1:No
           if (dot(Training_Set(i,:),Training_Set(j,:))~=0), found = 0; end
       end
   end
end

end

