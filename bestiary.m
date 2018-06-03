function [ Image ] = bestiary( collection,  m, n, mods, M, N)
%BESTIARY Summary this function produces an images of a colection of images of flies

trainingHist = (1/size(collection,1))*ones(size(collection,1),1);

temp = showRNA(collection(1,:),mods,m,n);
Patt_Size = size(temp,1);

Offset_Top = 8;
Offset_Right = 2;

Image = zeros(M*(Offset_Top+Patt_Size),N*(Patt_Size+Offset_Right));

for i=1:M*N, Image(floor((i-1)/M)*(Patt_Size+Offset_Top)+1+Offset_Top:floor((i-1)/M + 1)*(Patt_Size+Offset_Top),mod(i-1,M)*(Patt_Size+Offset_Right)+1:mod(i-1,M)*(Patt_Size + Offset_Right)+Patt_Size) = showRNA(collection(i,:),mods,m,n); end

%squares
borderWidth = 1;
maxlength = (Patt_Size - 4*borderWidth)/3;
maxVal = 0.5; %%%%0.5+0.5*()

%Training
for i=1:M*N,
    sizeSquare = floor(maxlength); %(trainingHist(i,1)/maxVal)*maxlength;
    Image(floor((i-1)/M)*(Patt_Size+Offset_Top)+1+borderWidth:floor((i-1)/M)*(Patt_Size+Offset_Top)+borderWidth+sizeSquare, mod(i-1,M)*(Patt_Size+Offset_Right)+1+borderWidth:mod(i-1,M)*(Patt_Size + Offset_Right)+borderWidth+sizeSquare)=1;
end

%Actual
for i=1:M*N,
    sizeSquare = floor(maxlength); %(trainingHist(i,1)/maxVal)*maxlength;
    Image(floor((i-1)/M)*(Patt_Size+Offset_Top)+1+borderWidth:floor((i-1)/M)*(Patt_Size+Offset_Top)+borderWidth+sizeSquare, mod(i-1,M)*(Patt_Size+Offset_Right)+2*borderWidth+sizeSquare+1:mod(i-1,M)*(Patt_Size + Offset_Right)+2*(borderWidth+sizeSquare))=1;
end

%Test
for i=1:M*N,
    sizeSquare = floor(maxlength); %(trainingHist(i,1)/maxVal)*maxlength;
    Image(floor((i-1)/M)*(Patt_Size+Offset_Top)+1+borderWidth:floor((i-1)/M)*(Patt_Size+Offset_Top)+borderWidth+sizeSquare, mod(i-1,M)*(Patt_Size+Offset_Right)+3*borderWidth+2*sizeSquare+1:mod(i-1,M)*(Patt_Size + Offset_Right)+3*(borderWidth+sizeSquare))=2*(trainingHist(i,1)/maxVal)-1;
end

%colors
%Image(Image==0)=-1;

end

