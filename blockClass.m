function [ Set ] = blockClass( slen, N, M)
%BLOCKCLASS generates a test set with all possible combinations of slen NxM
%blocks, where each block's direction is either up (+1) or down (-1)

Set = kron(de2bi(0:(2^slen)-1,'left-msb'), ones(N,M));
Set(Set == 0) = -1;

end

