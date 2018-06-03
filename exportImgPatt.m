function [ pattern ] = exportImgPatt( phenotype, M, K, scale )
%EXPORTIMGPATT Used to generate images that corresponds to intermediate suboptimal phenotypic states.

if (M*K ~= length(phenotype))
    disp('exportImgPatt: Invalid arguments given');
    return;
end

temp = [];
for i=1:M,
    if phenotype((i-1)*K+1:i*K) == ones(K,1)
        temp = [temp 'A'];
    elseif phenotype((i-1)*K+1:i*K) == zeros(K,1)
        temp = [temp 'B'];
    else
        temp = [temp 'C'];
    end
end

nff = strfind(temp,'C');

if nff
    
    %non-functional features
    temp1 = temp;
    temp2 = temp;
    temp1(nff) = 'A';
    temp2(nff) = 'B';
    
    %retrieve images
    pattern1 = imread(['C:\Users\User\Desktop\fruit fly\fly\fly_v3\fly_pics\', temp1, '.jpg']);
    pattern2 = imread(['C:\Users\User\Desktop\fruit fly\fly\fly_v3\fly_pics\', temp2, '.jpg']);
 
    %rescale
    pattern1 = imresize(pattern1,scale);
    pattern2 = imresize(pattern2,scale);
    
    %add noise
    for m = 1:length(nff)
        %calculate the amount of noise
        noise_level = sum(phenotype((nff(m)-1)*K+1:nff(m)*K)==ones(K,1))/K; %wrt to 'A'
        
        mask_region = zeros(size(pattern1,1),size(pattern1,2));
        if (nff(m) == 1)
            b = ceil(scale*40); %bits-block noise
            mask_region(ceil(scale*640):size(pattern1,1)-ceil(scale*100),ceil(scale*50):ceil(scale*340)) = 1;
        elseif nff(m) == 2
            b = ceil(scale*100);
            [i,j]= find(~mask_region);
            %line 1
            a_x = ceil(scale*100);
            a_y = ceil(scale*400);
            b_x = ceil(scale*0);
            b_y = ceil(scale*400);
            %line 2
            a_x_2 = ceil(scale*540);
            a_y_2 = ceil(scale*565);
            b_x_2 = ceil(scale*37);
            b_y_2 = ceil(scale*804);
            for k=1:length(i), mask_region(i(k),j(k)) = (det([ b_x - a_x  i(k) - a_x; b_y - a_y  j(k) - a_y]) <0) && det([ b_x_2 - a_x_2  i(k) - a_x_2; b_y_2 - a_y_2  j(k) - a_y_2]) > 0; end
        elseif nff(m) == 3
            b = ceil(scale*100);
            [i,j]= find(~mask_region);
            %line 1
            a_x = ceil(scale*608);
            a_y = ceil(scale*647);
            b_x = ceil(scale*255);
            b_y = ceil(scale*1098);
            %line 2
            a_x_2 = ceil(scale*540);
            a_y_2 = ceil(scale*565);
            b_x_2 = ceil(scale*37);
            b_y_2 = ceil(scale*804);
            for k=1:length(i), mask_region(i(k),j(k)) = (det([ b_x - a_x  i(k) - a_x; b_y - a_y  j(k) - a_y]) >0) && det([ b_x_2 - a_x_2  i(k) - a_x_2; b_y_2 - a_y_2  j(k) - a_y_2]) < 0; end
        elseif nff(m) == 4
            b = ceil(scale*50);
            mask_region(ceil(scale*500): size(pattern1,1)-ceil(scale*120), ceil(scale*500):size(pattern1,2)-ceil(scale*40)) = 1;
        end
                
        mask = (rand(ceil(size(pattern1,1)/b),ceil(size(pattern1,2)/b))<noise_level);
        mask = kron(mask,ones(b)); %expand
        mask = ((mask_region) & mask(1:size(pattern1,1),1:size(pattern1,2)));
        [i,j]= find(mask);
        pattern = pattern2;
        for k=1:length(i), pattern(i(k),j(k),:) = pattern1(i(k),j(k),:); end

        %for k=1:length(i), pattern(i(k),j(k),2:3) = 0; end

        
        pattern2 = pattern;
    end
else
    %retrieve in-class pattern
    pattern = imread(['C:\Users\User\Desktop\fruit fly\fly\fly_v3\fly_pics\', temp, '.jpg']);
    pattern = imresize(pattern,scale);

end

%pattern = imresize(pattern,0.82);

end

