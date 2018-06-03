function [ ] = genFigure1( OUT, T, tau1, tau2, Training_Set, Test_Set )
% Plot results to show overfitting

figure;
plot(OUT);
xlabel('Evolutionary Time (Epochs)');
ylabel('Regulatory Coefficients');
axis square;

B = vec2mat(OUT(end,:),size(Test_Set,2));
hinton(B,max(max(abs(B))));

%[Training_Error,Test_Error, ~, ~, ~]=findErrors_v2(OUT,T,tau1,tau2,Training_Set,Test_Set);
%figure;
%plot(Training_Error, '.g');
%hold on;
%plot(Test_Error, '.r');
%hold off;
% axis square;
% xlabel('Evolutionary Time (Epochs)');
% ylabel('Chi-squared Error');
% legend('Training Error','Test Error');
% 
% dist2fi

end

