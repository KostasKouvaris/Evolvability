clear;

Test_Set = generalBlockClass(4);

%H = (2*(net(sobolset(16),1000))-1)';

Training_Set = Test_Set([5 3 15],:);

%Add Noise (optional)
% Training_Set = Test_Set;
% for i=1:size(Training_Set,1)
%     for j=1:size(Training_Set,2)
%         if rand()<(1/size(Training_Set,2))
%             Training_Set(i,j) = (-1)*Training_Set(i,j);
%         end
%     end
% end

% Training_Set = [ -1 -1 -1 -1 -1 -1 -1 -1  1  1  1  1  1  1  1  1
%                  -1 -1 -1 -1  1  1  1  1  1  1  1  1 -1 -1 -1 -1
%                  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1  1  1  1  1];

% Training_Set = [ -1 -1 -1 -1 -1 -1 -1 -1  1  1  1  1  1  1  1  1
%                  -1 -1 -1 -1  1  1  1  1  1  1  1  1 -1 -1 -1 -1
%                  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1];


%RNA
%Training_Set = PattGen(4);
%Training_Set = [Training_Set -1*Training_Set];

%tempOrder = randperm(8);
%Training_Set = Test_Set(tempOrder(1:4),:);
%tempOrder = randi(size(Test_Set,1),1,16);
%Training_Set = orthogonal(Test_Set,4);

% Total_no = size(Test_Set,1);
% %r_index = 16;
% %Training_Set = Training_Set([1:r_index-1 r_index+1:end],:);
% %samples_no = [1:r_index-1 r_index+1:16];
% k = 13;
% samples_no = 1:Total_no;
% for i=1:Total_no-k
%     n = length(samples_no);
%     r_index = randi(n);
%     samples_no = samples_no([1:r_index-1 r_index+1:end]);
% end

%samples_no = randi(size(Test_Set,1),1,5);
% Training_Set = Test_Set(samples_no,:);
%load('TS_3')

N = size(Training_Set,1);
M = size(Training_Set,2);

%add stochastic noise
%for i=1:N, for j=1:M, if (rand()<2/M), Training_Set(i,j)=(-1)*Training_Set(i,j); end, end, end
%Training_Set = Training_Set + normrnd(0,1,N,M);

T = 15;
tau1 = 1;
tau2 = 0.2;

lr = 1;
epochs = 200; 
on_period = 4000;
t_max = epochs * N * on_period;

subplot_idx = 0;

%Last_Training_Error = [];
%Last_Test_Error = [];

%No_ErrorTypes = 6;
%ErrorTypes_Labels ={'Hellinger','aHellinger','Diff','aDiff','Abs','aAbs'};

OUT = [];

for lambda = 0:0 
    
    lambda
    
    subplot_idx = subplot_idx + 1;
    
    %Initialise
    G = zeros(M,1); B = zeros(M); B = 0*Training_Set'*Training_Set/3; 
    
    mult = 1;    
    output_b = zeros(epochs/mult+1, M^2);
    output_b(1,:) = B(:)';
    
    Patt_ID = 0;
    Patt_Set = 1:N;
    
    
    %fit = nan(t_max,1);

    P = develop( G, B, T,tau1,tau2);
    
    for t = 1:t_max
        
        
        if (mod(t,N*on_period) == 0), Patt_Set = randperm(N); end
        
        %alternate selective environments
        if (mod(t,on_period) == 1)
            
            
            %Deterministic
            Patt_ID = mod(Patt_ID, size(Training_Set,1))+1;
            S = Training_Set(Patt_Set(Patt_ID),:);
            fitP = fitness_v2(P,S,B,lambda,2);

%             %add stochastic noise by flipping modules
%             for i=1:4
%                 if (rand()<0.5)
%                     S((i-1)*4+1:i*4) = (-1)*S((i-1)*4+1:i*4);
%                 end
%             end
%                             


            %add stochastic noise by flipping characters
%             r_idx = (rand(16,1)<0.5);
%             S(r_idx) = (-1)*S(r_idx);

%             %dropout - output layer
%             r_idx = (rand(16,1)<0.1);
%             S(r_idx) = 0;

            %S = Test_Set(2,:);
            
            %Stochastic
            %S = Training_Set(randi(N),:);
            
            %Equilibrated Gs
            G = S';
            %add stochastic noise
%             noisyBits = 2;
%             for i=1:M
%                 if (rand()<0.33)
%                     r_idx = randperm(M);
%                     G(r_idx(noisyBits)) = (-1)*G(r_idx(noisyBits));
%                 end
%             end
% 
%             %dropout - input layer
%             r_idx = (rand(16,1)<0.7);
%             G(r_idx) = 0;

%             %add stochastic noise by flipping characters
%             r_idx = (rand(16,1)<0.3);
%             G(r_idx) = (-1)*G(r_idx);
% 
            mG = G;
            
            %S = Target;
            %B = Training_Set'*Training_Set/size(Training_Set,1);
            %B = Test_Set'*Test_Set/size(Test_Set,1); %optimal
        end
        
        %mG = S' + normrnd(0,0*0.00037,M,1);
        
        %add stochastic noise
        %         for i=1:M
        %         if (rand()<0.001*lambda)
        %          %noisyBits = 1;
        %          %r_idx = randperm(M);
        %          G(i,1) = (-1)*G(i,1);
        %         end
        %         end
        
        %mG = G;
        
        
        %mG = mutate_gene(G);
        mB = mutate_weights_v2(B);
        mP = develop_v2(mG,mB,T,tau1,tau2);
                
        %tmP = mP + normrnd(0,0.000002,M,1);
        %r_idx = rand(M,1)<0.1;
        %tmP(r_idx) = -1 * tmP(r_idx);
        %tmP = mP+ normrnd(0,0.000002,M,1);
        %tmfitP = fitness(tmP,S,mB,lambda,2);
        %mP = tmP;
        mfitP = fitness_v2(mP,S,mB,lambda,2);
        
        
        %mP = develop(mG, B,T,tau1,tau2)/(tau1/tau2);
        %if (fitness(mP,S) > fitness(P,S)), G = mG; end
        
        if (mfitP - fitP > 0)
          
            %G = mG;
            B = mB;
            P = mP
            fitP = mfitP;
            %[S' mP fitness(mP,S,mB,lambda,2)*ones(length(S),1)]
        end
                
        if (mod(t,mult*N*on_period) == 0)
            %lambda
            disp([num2str(100*(t/t_max)) '%']);
            %[S' mP fitness(mP,S,mB,lambda,2)*ones(length(S),1)]
            %disp(t);
            %Test_Error(ceil(t/10000),:) = HD(H, B, Bias, Test_Set, tau1, tau2, T, lr);
            %Training_Error(ceil(t/10000),:) = HD(H, B, Bias, Training_Set, tau1, tau2, T, lr);
            output_b(ceil(t/(mult*N*on_period))+1,:) = B(:)';
        end
    end
    
    
    %Last_Training_Error = [Last_Training_Error Training_Error(end,1)];
    %Last_Test_Error = [Last_Test_Error Test_Error(end,1)];
    %Last_Training_Error = [Last_Training_Error; MSE(H, B, Test_Set, tau1, tau2, T, lr)];
    %Last_Test_Error = [Last_Test_Error; MSE(H, B, Training_Set, tau1, tau2, T, lr)];
    
    %plot errors
    % f = figure;
    % for k = 1:No_ErrorTypes
    %     subplot(2,3,k);
    %     plot(Training_Error(:,k),'--.g'); hold on; plot(Test_Error(:,k),'--.r'); hold off;
    %     axis square;
    %     %legend('Training Error','Generalisation Error');
    %     xlabel('Epochs'); ylabel('Error');
    %     title(ErrorTypes_Labels(k));
    % end
    
    %plot: evolution of coefficients
    % figure;
    % plot(output_b);
    % axis square;
    % xlabel('Generations'); ylabel('Coefficients');
    % title('Evolution of B matrix');
    OUT = [OUT; output_b];
    
end

%fit = vec2mat(fit,on_period);
%figure; shadedErrorBar(1:on_period,mean(fit),std(fit),'r');

%plot last errors
% f = figure;
% for k = 1:No_ErrorTypes
% %    subplot(2,3,k);
%     plot(0:2:60, Last_Training_Error(:,k),'--.g'); hold on; plot(0:2:60, Last_Test_Error(:,k),'--.r'); hold off;
%     axis square;
%     legend('Training Error','Generalisation Error');
%     xlabel('Lambda'); ylabel('Errors');
%     %title(ErrorTypes_Labels(k));
% end

%hinton(B,max(max(abs(B))));