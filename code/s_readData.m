%image file root
imageRoot = '../files/';

%read ground truth file
gtFilePath = strcat(imageRoot, 'gt.txt');
rGTdata = TSD_readGTData(gtFilePath);

