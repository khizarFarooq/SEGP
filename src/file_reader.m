function inputMatrix = file_reader()

directory = dir('F:\matlab\Data Set\*.png');         %read all images in directory
noOfFiles = length(directory);    %get file count
inputMatrix = ones(noOfFiles,15);
for loop = 1 : noOfFiles
   tempName = directory(loop).name;
   imageData = imread(tempName);
   [width,height,blackPixels,bbx,bby,bbh,bbw,s_length,feature,startingXav,startingYav,endingXav,endingYav,thetaav,rhoav] = feature_extractor(imageData);
   inputMatrix(loop,1) = width;
   inputMatrix(loop,2) = height;
   inputMatrix(loop,3) = blackPixels;
   inputMatrix(loop,4) = bbx;
   inputMatrix(loop,5) = bby;
   inputMatrix(loop,6) = bbh;
   inputMatrix(loop,7) = bbw;
   inputMatrix(loop,8) = s_length;
   inputMatrix(loop,9) = feature;
   inputMatrix(loop,10) = startingXav;
   inputMatrix(loop,11) = startingYav;
   inputMatrix(loop,12) = endingXav;
   inputMatrix(loop,13) = endingYav;
   inputMatrix(loop,14) = thetaav;
   inputMatrix(loop,15) = rhoav;
%    inputMatrix(loop,8) = centroidx;
%    inputMatrix(loop,9) = centroidy;
%    inputMatrix(loop,8) = area;
   
   %fprintf('========= %s%=========',tempName)
   
end

end