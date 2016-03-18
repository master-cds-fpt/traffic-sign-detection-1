%list all files 
%image file root
imageRoot = '../files/';

%read ground truth file
gtFilePath = strcat(imageRoot, 'gt.txt');

%rGTdata contains fileNo, ROI, and class info
rGTdata = TSD_readGTData(gtFilePath);

numOfTrafficSigns = size(rGTdata,2);

testProhibitoryFiles = [];
testMandatoryFiles = [];
testDangerFiles = [];
testOtherFiles = [];

%number of samples in 600 images
testLimit = 853;

%filter ground truth data
for i = testLimit:numOfTrafficSigns
    if strcmp(rGTdata(i).category,'mandatory')
        testMandatoryFiles = [testMandatoryFiles; rGTdata(i)];
    elseif strcmp(rGTdata(i).category, 'prohibitory')
        testProhibitoryFiles = [testProhibitoryFiles; rGTdata(i)];
    elseif strcmp(rGTdata(i).category, 'danger')
        testDangerFiles = [testDangerFiles; rGTdata(i)];
    elseif strcmp(rGTdata(i).category, 'other')
        testOtherFiles = [testOtherFiles; rGTdata(i)];
    end
end

%generate training data for prohibitory files
testProhibitoryFeatures = f_generate_recognition_testing_data( testProhibitoryFiles, imageRoot, prohibitoryMin, prohibitoryNormalizer );

%generate training data for mandatory files
testMandatoryFeatures = f_generate_recognition_testing_data( testMandatoryFiles, imageRoot, mandatoryMin, mandatoryNormalizer );

%generate training data for danger files
testDangerFeatures = f_generate_recognition_testing_data( testDangerFiles, imageRoot, dangerMin, dangerNormalizer );


testOtherFeatures = f_generate_recognition_testing_data( testOtherFiles, imageRoot, otherMin, otherNormalizer );

