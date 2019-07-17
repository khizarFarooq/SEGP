function [width , height , blackPixels,bbx,bby,bbh,bbw,s_length,feature,startingXav,startingYav,endingXav,endingYav,thetaav,rhoav] = feature_extractor(image)
% width=return width of black pixel
% height=return height of balck pixel
%blackpixels=no of balck pixels in the binary file of the image
%bbx=x value of bounding box
% bby=y value of bounding box
% bbh=height of bounding box
% bbw= width of bounding box
% s_length= lenth of white pixels in sekeleton of image
% feature=contor function feature.
    
    
    
    Ibw = im2bw(image,graythresh(image));
   Iedge = edge(Ibw);
   se=strel('square',2);
   Iedge2=imdilate(Iedge,se);
   Ifill=imfill(Iedge2,'holes');
   Ifill2= bwmorph(Ifill,'erode');  
    
   [rows , cols] = find(Ibw == 0);  
    width = max(cols) - min(cols);
    height = max(rows) - min(rows);
    blackPixels = length(rows);
    
    
% % % % % % % % % % % % % % % % % % % sekeleton white pixel count
   sekeleton=bwmorph(Ibw,'skel');
   endpoints=bwmorph(sekeleton,'endpoints');
   [s_rows , s_cols] = find(endpoints == 1);
   s_length=length(s_rows);
   
% % % % % % % % % % % % % % % % % % % % % % % % % % % %  contor feature  
    contor=contour_moments(Ibw);
    feature=contor(1,1)+contor(1,2),contor(1,3),contor(1,4);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% % % % % % % % % % % % % % % % % % % % % % % hough
 [startingXav,startingYav,endingXav,endingYav,thetaav,rhoav]=linesinfo(image);



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

  [Ilabel, num] = bwlabel(Ifill2);
%     disp(num);
    Iprops = regionprops(Ilabel);
    Ibox = [Iprops.BoundingBox];
%     area=[Iprops.Area];
%     centroidx=[Iprops.Centroid(1,1)];
%     centroidy=[Iprops.Centroid(1,2)];
    
    bbx=Ibox(1,1);
    bby=Ibox(1,2);
    bbh=Ibox(1,3);
    bbw=Ibox(1,4);

end