function [ negativeColorSamples ] = f_generateNegativeTrainingData( imgRootPath, ...
    colorChannel, channelThreshold)
    
    %colorChannel         :The channel for which negative training data is being
    %                      collected
    %channelThreshold     :Channel threshold for considering the color as
    %                      positive
    %imgRootPath          :Root path for images
    
    numSamples = 200000;

    imgRootPath = '../files/';

    %list all files inside root directory
    listOfFiles = dir(imgRootPath);

    %filter out directories from this list
    listOfFiles([listOfFiles.isdir]) = [];
    listOfFiles([listOfFiles.bytes]<15000) = [];

    negativeColorSamples = [];
    channel2 = mod(colorChannel+1, 3);
    channel3 = mod(colorChannel+2, 3);

    if channel2 == 0
        channel2 = 3;
    elseif channel3 == 0
        channel3 = 3;
    end

    for imgId = 1:600
    
        imgPath = strcat(imgRootPath, listOfFiles(imgId).name);
        img = imread(imgPath);
        
        width = size(img, 1);
        height = size(img, 2);
        
        numElements = width*height;
        
        for pointCounter=1:1000
            randomIndex = randi([1, numElements]);
            [i,j] = ind2sub([size(img,1), size(img,2)], randomIndex);
            color = img(i,j,:);

            if(color(colorChannel) < color(channel2) & color(colorChannel)<color(channel3))
                negativeColorSamples = [negativeColorSamples, img(i,j,:)];
            end        
        end    
    end
end