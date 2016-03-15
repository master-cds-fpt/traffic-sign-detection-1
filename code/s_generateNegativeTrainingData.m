numSamples = 200000;

imgRootPath = '../files/';

%list all files inside root directory
listOfFiles = dir(imgRootPath);

%filter out directories from this list
listOfFiles([listOfFiles.isdir]) = [];
listOfFiles([listOfFiles.bytes]<15000) = [];

negativeColorSamples = [];

for imgId = 1:size(listOfFiles, 1)
    
    imgPath = strcat(imgRootPath, listOfFiles(imgId).name);
    display(imgPath);
    img = imread(imgPath);
    
    width = size(img, 1);
    height = size(img, 2);
    
    numElements = width*height;
    
    for pointCounter=1:223
        randomIndex = randi([1, numElements]);
        [i,j] = ind2sub([size(img,1), size(img,2)], randomIndex);
        negativeColorSamples = [negativeColorSamples, img(i,j,:)];
    end
    
end
