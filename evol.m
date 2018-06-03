function [ st_ev, lt_ev ] = evol( B, T, tau1, tau2, env_period, Training_Set, Test_Set )
% Evaluates short and long term evolvability

%st_ev: short term evolvability
%lt_ev: long term evolvability

Training_N = size(Training_Set,1);
Training_M = size(Training_Set,2);
Test_N = size(Test_Set,1);

lambda = 0;
iter_n = 10; %number of iterations

%evaluate short-term evolvability - average fitness
t_max = env_period * Training_N;

temp_st_ev = zeros(t_max,iter_n);

for i=1:iter_n
    
    i
    
    %initialise
    Patt_ID = 0;
    Patt_Set = randperm(Training_N);
    G = zeros(Training_M,1);
    
    for t=1:t_max
        %environmental switching
        if (mod(t,env_period) == 1)
            Patt_ID = mod(Patt_ID, Training_N)+1;
            S = Training_Set(Patt_Set(Patt_ID),:);
        end
        %mutate and select
        P = develop( G, B, T,tau1,tau2);
        mG = mutate_gene(G);
        mP = develop(mG,B,T,tau1,tau2);
        if ((fitness(mP,S,B,lambda,2))> (fitness(P,S,B,lambda,2))), G = mG; end
        %store data
        temp_st_ev(t,i) = fitness(P,S,B,lambda,2);
    end
end

st_ev = mean(mean(temp_st_ev,2));

%evaluate long-term evolvability - average fitness
t_max = env_period * Test_N;

temp_lt_ev = zeros(t_max,iter_n);

for i=1:iter_n
    
    i
    
    %initialise
    Patt_ID = 0;
    Patt_Set = randperm(Test_N);
    G = zeros(Training_M,1);
    
    for t=1:t_max
        %environmental switching
        if (mod(t,env_period) == 1)
            Patt_ID = mod(Patt_ID, Test_N)+1;
            S = Test_Set(Patt_Set(Patt_ID),:);
        end
        %mutate and select
        P = develop( G, B, T,tau1,tau2);
        mG = mutate_gene(G);
        mP = develop(mG,B,T,tau1,tau2);
        if ((fitness(mP,S,B,lambda,2))> (fitness(P,S,B,lambda,2))), G = mG; end
        %store data
        temp_lt_ev(t,i) = fitness(P,S,B,lambda,2);
    end
end

lt_ev = mean(mean(temp_lt_ev,2));

end

