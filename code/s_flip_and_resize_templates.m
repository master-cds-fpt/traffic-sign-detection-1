mandatoryTemplatePath = '../mandatory/templates/';
dangerTemplatePath = '../danger/templates/';
prohibitoryTemplatePath = '../prohibitory/templates/';

currentPath = dangerTemplatePath;

files = dir(currentPath);
%filter out directories from this list
files([files.isdir]) = [];

for idx = 1: size(files,1)
       
        
        
    filePath = strcat(currentPath, files(idx).name);
    template = imread(filePath);
    template = f_flip_and_resize(template);
    imwrite(template, filePath, 'JPEG'); 
end