%image file root
imageRoot = '../files/';

%read ground truth file
gtFilePath = strcat(imageRoot, 'gt.txt');

%rGTdata contains fileNo, ROI, and class info
rGTdata = TSD_readGTData(gtFilePath);

%example on how to read and show image

img = imread(strcat(imageRoot, '0000.ppm'));
imshow(img);