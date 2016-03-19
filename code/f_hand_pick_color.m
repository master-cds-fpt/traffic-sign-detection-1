imgRootPath = '../files/';
colorChannel = 1;


%colorChannel         :The channel for which training data is being
%                      collected
%channelThreshold     :Channel threshold for considering the color as
%                      positive
%imgRootPath          :Root path for images


prohibitoryClassIds = [0, 1, 2, 3, 4, 5, 7, 8, 9, 10, 15, 16];
mandatoryClassIds = [33, 34, 35, 36, 37, 38, 39, 40];
%dangerClassIds = [11, 18, 19, 20 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31];

if colorChannel == 1
    classList = prohibitoryClassIds;
else
    classList = mandatoryClassIds;
end

positiveSamples = [];

for folderIdx = 1:numel(classList)
   
    %generate folder names
    folderName = classList(folderIdx);
    if folderName < 10
        folderName = strcat('0', num2str(folderName));
    end
    folderName = strcat(imgRootPath, num2str(folderName), '/');
    
    display(folderName);
    
    %list files inside a directory
    listOfFiles = dir(folderName);
    
    %filter out directories from this list
    listOfFiles([listOfFiles.isdir]) = [];
    
    %for each file in directory
    for fileId = 1:size(listOfFiles, 1)

        if(size(positiveSamples,1)>2500)
            break;
        end

        %get filePath
        filePath = strcat(folderName, listOfFiles(fileId).name);
        
        %read image
        img = imread(filePath);
        imshow(img);
        [i j] = ginput(5);
        i = floor(i);
        j  = floor(j);
        pos = j>0&j<size(img,1) & i>0&i<size(img,2);
        i = i(pos);
        j = j(pos);
        for id = 1:size(i,1)
            positiveSamples = [positiveSamples, img(j(id),i(id),:)]; 
        end
    end 
end
