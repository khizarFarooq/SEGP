
 function [startingXav,startingYav,endingXav,endingYav,thetaav,rhoav]=linesinfo(I)
 BW = edge(I,'canny');
 [H,T,R] = hough(BW);
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
% x = T(P(:,2)); y = R(P(:,1));
%  plot(x,y,'s','color','yellow');
% % Find lines and plot them
 lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7); %lines for each i
 %len=length(lines{i}); %counts number of lines in an image
 %siz= (images{i});
 %hor= horzcat([Ibox{i}(1,1),Ibox{i}(1,2),Ibox{i}(1,3),Ibox{i}(1,4),area{i}(1,1),centroid{i}(1,1),centroid{i}(1,2),len,char]);
 %bb=vertcat(bb,hor);
oneline=lines(1,1);
 div=length(lines);
 startingXav=0;
 startingYav=0;
 endingXav=0;
 endingYav=0;
 thetaav=0;
 rhoav=0;
 for count=1:div;
% startingXav= ((oneline.point1(1,1))+(secondline.point1(1,1))) ;
% startingYav= ((oneline.point1(1,2))+(secondline.point1(1,2))); 
% endingXav= ((oneline.point2(1,1))+(secondline.point2(1,1))) ;
% endingYav= ((oneline.point2(1,2))+(secondline.point2(1,2)));
% thetaav=(oneline.theta+secondline.theta) /2;
% rhoav= (oneline.rho+secondline.rho) /2;
%  oneline=lines{1}(1,count);
%  secondline=lines{1}(1,count);
startingXav=(startingXav +((oneline.point1(1,1))));
startingYav= startingYav+((oneline.point1(1,2)));
endingXav=endingXav+ ((oneline.point2(1,1)));
endingYav= endingYav+((oneline.point2(1,2)));
thetaav=thetaav+(oneline.theta);
rhoav=rhoav+ (oneline.rho);
if(count~=div)
   count=count+1;
 oneline=lines(1,count);
else
    break;
end


 end
startingXav=startingXav/div;
 endingXav=endingXav/div;
endingYav=endingYav/div;
startingYav=startingYav/div;
thetaav=thetaav/div;
rhoav=rhoav/div;
 


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




 end




