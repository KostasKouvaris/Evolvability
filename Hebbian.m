function [ RNN ] = Hebbian( TS, e )
%HEBBIAN performs Hebbian learning on a fully recurrent (neural) network
%(RNN) with learning rate e. The training patterns to be imprinted are
%sequentially given by the training set (TS).

N = size(TS,2);
M = size(TS,1);

tRNN = zeros(N);
for i=1:M
    input = TS(i,:);
    tRNN =  tRNN + input'*input;
end

RNN = e*tRNN/M;
end

