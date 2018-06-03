function [ img ] = showTheClass( Training_Set, Test_Set, modules, m_size)
% Generates an image of the class using the images of flies.

no_pics = size(Test_Set,1);

M = floor(no_pics^.5);
N = M + (ceil(no_pics^.5)-M);

tempPatt = exportImgPatt(Test_Set(1,:)',modules,m_size);
size_x = size(tempPatt,1); 
size_y = size(tempPatt,2);
size_d = 20;

pic = uint8(zeros(N*(size_x+size_d)+size_d,M*(size_y+size_d)+size_d,3));

for i=1:no_pics
    tempPatt = exportImgPatt(Test_Set(i,:)',modules,m_size);
    pic(floor((i-1)/M)*(size_x+size_d)+size_d+1:floor((i-1)/M)*(size_x+size_d)+size_x+size_d,mod(i-1,M)*(size_y+size_d)+size_d+1:mod(i-1,M)*(size_y+size_d)+size_y+size_d,:) = tempPatt;
end

%outline training samples
no_pics = size(Training_Set,1);
list = find(ismember(Test_Set,Training_Set,'rows'));
for i=1:no_pics
    %pic(floor((list(i)-1)/M)*(size_x+size_d)+size_d+1:floor((list(i)-1)/M)*(size_x+size_d)+size_x+size_d,mod(list(i)-1,M)*(size_y+size_d)+size_d+1:mod(list(i)-1,M)*(size_y+size_d)+size_y+size_d,[1 3]) = 120;
    %upper
    pic(floor((list(i)-1)/M)*(size_x+size_d)+1:floor((list(i)-1)/M)*(size_x+size_d)+size_d, mod(list(i)-1,M)*(size_y+size_d)+1:mod(list(i)-1,M)*(size_y+size_d)+size_y+2*size_d,1)= 255;
    %lower
    pic(floor((list(i)-1)/M)*(size_x+size_d)+size_x+size_d+1:floor((list(i)-1)/M)*(size_x+size_d)+size_x+size_d+size_d, mod(list(i)-1,M)*(size_y+size_d)+1:mod(list(i)-1,M)*(size_y+size_d)+size_y+2*size_d,1)= 255;
    %left
    pic(floor((list(i)-1)/M)*(size_x+size_d)+1:floor((list(i)-1)/M)*(size_x+size_d)+size_x+2*size_d,mod(list(i)-1,M)*(size_y+size_d)+1:mod(list(i)-1,M)*(size_y+size_d)+size_d,1) = 255;
    %right
	pic(floor((list(i)-1)/M)*(size_x+size_d)+1:floor((list(i)-1)/M)*(size_x+size_d)+size_x+2*size_d,mod(list(i)-1,M)*(size_y+size_d)+size_y+size_d+1:mod(list(i)-1,M)*(size_y+size_d)+size_y+2*size_d,1) = 255;
end

figure;
imshow(pic);
end

