function [ Set ] = generalBlockClass(M)
%BLOCKCLASS generates a test set with all possible combinations of slen NxM
%blocks, where each block's direction is either up (+1) or down (-1)

% M - #modules

Modules = [1 -1 1 -1; 1 1 -1 -1; -1 1 1 -1; 1 1 1 1]';
Set = vec2mat(cell2mat(cellfun(@(x) mat2vec(bsxfun(@(x,y) x*y, x, Modules(:,1:M))), mat2cell(2*de2bi(0:(2^M)-1,'left-msb')-1, ones(1,2^M), M), 'UniformOutput',0)),M*4);

end

