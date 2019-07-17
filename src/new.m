

I=imread('c.jpeg');
% I=imread('4.png');
% I=imread('Capture.png');
% figure;imshow(I);title('simple');
Igray = rgb2gray(I);
% figure;imshow(Igray);title('gray scale');
Ibw = im2bw(Igray,graythresh(Igray));
% figure;imshow(Ibw);title('binary');

Iedge = edge(Ibw);
% Iedge2 = edge(uint8(Ibw));

se=strel('square',2);
Iedge2=imdilate(Iedge,se);

Ifill=imfill(Iedge2,'holes');
Ifill2= bwmorph(Ifill,'erode');
Ifill3= bwmorph(Ifill2,'dilate',1);
Ifill4=imfill(Ifill3,'holes');

[Ilabel, num] = bwlabel(Ifill);
disp(num);
Iprops = regionprops(Ilabel);
Ibox = [Iprops.BoundingBox];
Ibox2=vertcat(Iprops.BoundingBox);
Ibox3=Ibox2;
 w = Ibox2(:,3);
h = Ibox2(:,4);
aspectRatio = w-h>4 | h-w>4;
filterIdx = aspectRatio' < 1;

Iprops(filterIdx)=[];
Ibox3=vertcat(Iprops.BoundingBox);

ITextRegion = insertShape(Igray, 'Rectangle', Ibox3,'LineWidth',3);
figure;imshow(ITextRegion);





xmin = Ibox3(:,1);
ymin = Ibox3(:,2);
xmax = xmin + Ibox3(:,3) - 1;
ymax = ymin + Ibox3(:,4) - 1;
% xmax = Ibox3(:,3)+10;
% ymax = Ibox3(:,4)+10;
% 
expansionAmount = 0.03;
xmin = (1-expansionAmount) * xmin;
ymin = (1-expansionAmount) * ymin;
xmax = (1+expansionAmount) * xmax;
ymax = (1+expansionAmount) * ymax;
% 

expandedBBoxes = [xmin ymin xmax-xmin+1 ymax-ymin+1];
% expandedBBoxes = [xmin ymin xmax+10 ymax+10];
IExpandedBBoxes = insertShape(I,'Rectangle',expandedBBoxes,'LineWidth',3);

figure
imshow(IExpandedBBoxes)
title('Expanded Bounding Boxes Text')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% testing arrea
% [mserRegions] = detectMSERFeatures(Igray,'ThresholdDelta',2);
% 
% figure
% imshow(Igray)
% hold on
% plot(mserRegions, 'showPixelList', true,'showEllipses',false)
% title('MSER regions')
% hold off
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% sz = size(Igray);
% pixelIdxList = cellfun(@(xy)sub2ind(sz, xy(:,2), xy(:,1)), ...
%     mserRegions.PixelList, 'UniformOutput', false);
% 
% % Next, pack the data into a connected component struct.
% mserConnComp.Connectivity = 1000;
% mserConnComp.ImageSize = sz;
% mserConnComp.NumObjects = mserRegions.Count;
% mserConnComp.PixelIdxList = pixelIdxList;
% 
% % Use regionprops to measure MSER properties
% mserStats = regionprops(mserConnComp, 'BoundingBox', 'Eccentricity', ...
%     'Solidity', 'Extent', 'Euler', 'Image');
% 
% % Compute the aspect ratio using bounding box data.
% bbox = vertcat(mserStats.BoundingBox);
% w = bbox(:,3);
% h = bbox(:,4);
% aspectRatio = w./h;
% 
% % Threshold the data to determine which regions to remove. These thresholds
% % may need to be tuned for other images.
% filterIdx = aspectRatio' > 3; 
% filterIdx = filterIdx | [mserStats.Eccentricity] > .995 ;
% filterIdx = filterIdx | [mserStats.Solidity] < .3;
% filterIdx = filterIdx | [mserStats.Extent] < 0.2 | [mserStats.Extent] > 0.9;
% filterIdx = filterIdx | [mserStats.EulerNumber] < -4;
% 
% % Remove regions
% mserStats(filterIdx) = [];
% mserRegions(filterIdx) = [];
% 
% 
% 
% figure
% imshow(Igray)
% hold on
% plot(mserRegions, 'showPixelList', true)
% title('filter MSER regions')
% hold off
% 
% 
% 
% 
% bboxes = vertcat(mserStats.BoundingBox);
% 
% % Convert from the [x y width height] bounding box format to the [xmin ymin
% % xmax ymax] format for convenience.
% xmin = bboxes(:,1);
% ymin = bboxes(:,2);
% xmax = xmin + bboxes(:,3) - 1;
% ymax = ymin + bboxes(:,4) - 1;
% 
% % Expand the bounding boxes by a small amount.
% expansionAmount = 0.02;
% xmin = (1-expansionAmount) * xmin;
% ymin = (1-expansionAmount) * ymin;
% xmax = (1+expansionAmount) * xmax;
% ymax = (1+expansionAmount) * ymax;
% 
% 
% % Clip the bounding boxes to be within the image bounds
% xmin = max(xmin, 1);
% ymin = max(ymin, 1);
% xmax = min(xmax, size(I,2));
% ymax = min(ymax, size(I,1));
% 
% % Show the expanded bounding boxes
% expandedBBoxes = [xmin ymin xmax-xmin+1 ymax-ymin+1];
% IExpandedBBoxes = insertShape(I,'Rectangle',expandedBBoxes,'LineWidth',3);
% 
% figure
% imshow(IExpandedBBoxes)
% title('Expanded Bounding Boxes Text')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






























 


% subplot(3,3,1),imshow(I);title('normal');subplot(3,3,2),imshow(Igray);title('gray scale');
% subplot(3,3,3),imshow(Ibw);title('Binary');subplot(3,3,4),imshow(Iedge);title('Edge detection');
% subplot(3,3,5),imshow(Iedge2);title('Dialate Edge');subplot(3,3,6),imshow(Ifill);title('Holes Filling');
% subplot(3,3,7),imshow(Ifill2);title('Bwmorph erode');subplot(3,3,8),imshow(Ifill4);
% 
% 
% hold on;
% %  rectangle('position',Ibox,'edgecolor','y');
% rectangle('position',[Ibox(1,1),Ibox(1,2),Ibox(1,4),Ibox(1,4)],'edgecolor','r');
% rectangle('position',[Ibox(1,5),Ibox(1,6),Ibox(1,7),Ibox(1,8)],'edgecolor','r');