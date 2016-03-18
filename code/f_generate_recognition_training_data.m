function features = f_generate_recognition_training_data( gtCategoryStruct, imageRoot )
    filePaths = [];
    features = [];
    
    for i=1:size(gtCategoryStruct, 1)
        
        %generate filePath
        fileNo = gtCategoryStruct(i).fileNo;
        if uint8(fileNo) < 10
            filePath = strcat(imageRoot, '0000', num2str(fileNo), '.ppm');
        elseif uint8(fileNo) < 100 
            filePath = strcat(imageRoot, '000', num2str(fileNo), '.ppm');
        else
            filePath = strcat(imageRoot, '00', num2str(fileNo), '.ppm');
        end
        filePaths = [filePaths; filePath];    
        
        %read image
        img = imread(filePath);
        
        %extract ROI
        leftCol = gtCategoryStruct(i).leftCol;
        topRow = gtCategoryStruct(i).topRow;
        rightCol = gtCategoryStruct(i).rightCol;
        bottomRow = gtCategoryStruct(i).bottomRow;
        currentRoi = img(topRow: bottomRow, leftCol:rightCol, :);
        grayCurrentRoi = rgb2gray(currentRoi);
        
        %resize ROI
        currentRoi = imresize(currentRoi, [32,32]);
        grayCurrentRoi = imresize(grayCurrentRoi, [32,32]);
        
        %get hog features
        hogFeatures = f_hog(grayCurrentRoi);
        
        %get color features
        colorFeatures = f_generate_color_features(currentRoi);
        
        currentFeatures = [hogFeatures; colorFeatures];
        currentFeatures = currentFeatures';
        
        %append to features
        features = [features; currentFeatures];
    end
end

