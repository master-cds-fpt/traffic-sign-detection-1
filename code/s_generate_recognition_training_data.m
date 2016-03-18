%list all files 
%image file root
imageRoot = '../files/';

%read ground truth file
gtFilePath = strcat(imageRoot, 'gt.txt');

%rGTdata contains fileNo, ROI, and class info
rGTdata = TSD_readGTData(gtFilePath);

numOfTrafficSigns = size(rGTdata,2);

prohibitoryFiles = [];
mandatoryFiles = [];
dangerFiles = [];


%filter ground truth data
for i = 1:numOfTrafficSigns
    if strcmp(rGTdata(i).category,'mandatory')
        mandatoryFiles = [mandatoryFiles; rGTdata(i)];
    elseif strcmp(rGTdata(i).category, 'prohibitory')
        prohibitoryFiles = [prohibitoryFiles; rGTdata(i)];
    elseif strcmp(rGTdata(i).category, 'danger')
        dangerFiles = [dangerFiles; rGTdata(i)];
    end
end

%generate training data for prohibitory files
prohibitoryFeatures = f_generate_recognition_training_data( prohibitoryFiles, imageRoot );

%generate training data for mandatory files
mandatoryFeatures = f_generate_recognition_training_data( mandatoryFiles, imageRoot);

%generate training data for danger files
dangerFeatures = f_generate_recognition_training_data( dangerFiles, imageRoot);

