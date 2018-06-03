function [ pic ] = dist2pics( dist, modules, m_size, Training_Set, Test_Set)
%DIST2PICS Get a distribution of phenotypes and produce a picture using flies images


threshold = 0.1;

allCombinations = blockClass(modules*m_size,1,1);
Half_Idx = min(allCombinations(:,13:16)==-1,[],2);
allCombinations = allCombinations(Half_Idx,:);
dist = dist(Half_Idx);

allCombinations(allCombinations == -1) = 0;
Training_Set(Training_Set == -1) = 0;
Test_Set(Test_Set == -1) = 0;

idx = [];

%training figure
%dist = ismember(allCombinations,Training_Set,'rows')/length(Training_Set);

%class figure
%dist = ismember(allCombinations,Test_Set,'rows')/length(Test_Set);
test_idx = ismember(allCombinations,Test_Set,'rows');
%dist(idx)

%dist = dist(Half_Idx);
%dist = ones(size(dist))/(length(dist));

%list = -1*sortrows(-1*[find(dist) dist(find(dist))],2);

test_list = [find(test_idx) dist(test_idx)]; %gets test targets
% dist(test_idx) = []; %remove test from the list
% allCombinations(test_idx,:)
list = -1*sortrows(-1*[find(dist) dist(find(dist))],2);
size(list)
list(find(ismember(list(:,1),find(test_idx),'rows')),:)=[];
size(list)
list = [test_list; list];

%list for 1-1 mapping figure
% list = list(randperm(size(list,1)),:); %shuffle
% idx = ismember(list(:,1),find(ismember(allCombinations,Test_Set,'rows')));
% temp_list =list(idx,:);
% list(idx,:) = [];
% list = [temp_list; list];

scales = list(:,2)/max(abs(list(:,2)));
%list = [list(1:length(idx),:); list(scales(length(idx)+1:end)>=threshold,:)];
%scales = list(:,2)/max(abs(list(:,2)));
Test_No = size(Test_Set,1);
max_pics =  Test_No + sum(scales(Test_No+1:end)>=threshold);
no_pics = min(64,max_pics);


%list = list(scales(length(idx)+1:end)>=threshold);
%list = list(randperm(size(list,1)),:); %shuffle


no_pics
%list for 1-1 mapping figure
% idx = randperm(no_pics);
% list = list(idx,:); %shuffle
% scales = scales(idx);

size_d = 20;
scale = 0.4;

% N = ceil(no_pics^.5);
% M = ceil(no_pics/N);

M = 8;
N = ceil(no_pics/M)

tempPatt = exportImgPatt_v4(Test_Set(1,:)',modules,m_size, scale);
size_x = size(tempPatt,1);
size_y = size(tempPatt,2);

size_y = size_y - 180;


pic = uint8(255*ones(N*(size_x+size_d)+size_d,M*(size_y+size_d)+size_d,3));

for i=1:no_pics
    
    i
    
    %skip
    if scales(i) < threshold, continue; end
    %if scales(i) == 0,continue; end
    
    %load
    tempPatt = exportImgPatt_v4(allCombinations(list(i,1),:)',modules,m_size,scale);
    tempPatt = imcrop(tempPatt,[40 1 size_y size_x]);
    
    %text
    %tempPatt = insertText(tempPatt,[0 0],[num2str(round(100*list(i,2)*100)/100),'%'],'FontSize',scale*130,'BoxColor',[255 255 255]);
    %tempPatt = insertText(tempPatt,[0 0],[num2str(round(100*list(i,2)*100)/100),'%'],'FontSize',scale*130,'BoxColor',[255 255 255]);
    
    %mirror
    if (i<=8)
        k = (i-1)*2 + 1;
        k = mod(k,8) + (k>8)*1;
    else
        k=i;
    end
    
    %rescale
    tempPatt = imresize(tempPatt,scales(i));
    temp_size_x = size(tempPatt,1);
    temp_size_y = size(tempPatt,2);
    %coordinates
    x_1 = floor((k-1)/M)*(size_x+size_d)+size_d+1; %upper
    x_2 = floor((k-1)/M)*(size_x+size_d)+temp_size_x+size_d; %lower
    y_1 = mod(k-1,M)*(size_y+size_d)+size_d+1; %left
    y_2 = mod(k-1,M)*(size_y+size_d)+temp_size_y+size_d; %right
    %centering
    cx_1 = ceil(x_1 + abs((temp_size_x-size_x)/2));
    cy_1 = ceil(y_1 + abs((temp_size_y-size_y)/2));
    cx_2 = ceil(x_2 + abs((temp_size_x-size_x)/2));
    cy_2 = ceil(y_2 + abs((temp_size_y-size_y)/2));
    %apply
    pic(cx_1:cx_2,cy_1:cy_2,:) = tempPatt;
    
    %apply borders for Training and Test samples
    %     if logical(ismember(allCombinations(list(i,1),:),Test_Set,'rows'))
    %         Test_radius = 100;
    %         offset = ceil(scale*(size_d+Test_radius));
    %         pic = insertShape(pic,'FilledCircle',[y_1 + size_y - offset x_1 + offset scale*Test_radius],'Color',[255 0 0 ],'Opacity',0.8);
    %     end
    if logical(ismember(allCombinations(list(i,1),:),Test_Set,'rows'))
        Test_radius = 60;
        offset = ceil(scale*(size_d+Test_radius));
        pic = insertShape(pic,'FilledCircle',[y_1 + size_y - offset - 10 x_1 + offset scale*Test_radius],'Color',[255 0 0 ],'Opacity',0.8);
        
        
    end
    if logical(ismember(allCombinations(list(i,1),:),Training_Set,'rows'))
        %         Test_radius = 60;
        %         offset = ceil(scale*(size_d+Test_radius));
        %         pic = insertShape(pic,'FilledCircle',[y_1 + size_y - offset - 10 x_1 + offset scale*Test_radius],'Color',[0 0 0 ],'Opacity',0.8);
        %
        Training_radius = 50;
        offset = ceil(scale*(size_d+Test_radius));
        pic = insertShape(pic,'FilledCircle',[y_1 + size_y - offset - 10  x_1 + offset scale*Training_radius],'Color',[0 255 0],'Opacity',0.8);
    end
    
    
    %
    
end

figure;
imshow(pic);
end

