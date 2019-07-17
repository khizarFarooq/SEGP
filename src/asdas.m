% I = imread('n.png');
% % I(2,5);
% % imshow(I);
% figure;imshow(I);
% rectangle('Position',[1,2,5,6]);
% % axis([0 128 0 128]);
% 


% header={'Image Name','Image Size'};

allimages= dir('*.png');
nimages=length(allimages);
% a=zeros(nimages);
bb=[];
for i=1:nimages;
   currentfilename = allimages(i).name;
   currentimage = imread(currentfilename);
   images{i} = currentimage;
   
%    image_size=size(currentimage);
% myFeature1(i,:)={currentfilename};
% myFeature2(i,:)={image_size};
   
   
   Ibw{i} = im2bw(currentimage,graythresh(currentimage));
   Iedge{i} = edge(Ibw{i});
   se=strel('square',2);
   Iedge2{i}=imdilate(Iedge{i},se);
   Ifill{i}=imfill(Iedge2{i},'holes');
   Ifill2{i}= bwmorph(Ifill{i},'erode');  
  
  [Ilabel{i}, num] = bwlabel(Ifill2{i});
%     disp(num);
    Iprops{i} = regionprops(Ilabel{i});
    Ibox{i} = [Iprops{i}.BoundingBox];
    area{i}=[Iprops{i}.Area];
    centroid{i}=[Iprops{i}.Centroid];
    
   
    
    char={'F'};
    hor=horzcat([Ibox{i}(1,1),Ibox{i}(1,2),Ibox{i}(1,3),Ibox{i}(1,4),area{i}(1,1),centroid{i}(1,1),centroid{i}(1,2),size(images{i}),char]);
    bb=vertcat(bb,hor);
    
end

xlswrite('text.xls',bb);
% myFeatures=[myFeature1,myFeature2];
% fileID=fopen('csvlist.csv','w');
% formatSpec = '%s %d %s\r';
% [nrows,ncols]=size(myFeatures);
% csvwrite('csvlist.csv',header);

% for row=1:nrows
%      %fprintf writes a space-delimited file.
%      fprintf(fileID,formatSpec,myFeatures{row,:});
% end
% %Close the file.
% fclose(fileID);
% 









