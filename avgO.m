function [ t1, t2] = avgO( input,T,tau1,tau2,Test_Set, avg_no)
%AVGO Aggregate training and test errors

t1 = [];
t2 = [];

t_max = 150;

for i = 1:10
    output_b = input((i-1)*t_max+1:(i-1)*t_max+t_max, :);
    
    Training_Set = Test_Set(avg_no(i,:),:);

    [a,b]=findErrors(output_b,T,tau1,tau2,Training_Set,Test_Set);
    t1 = [t1 a];
    t2 = [t2 b];
end


end

