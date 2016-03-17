load('../data/positiveSamples', 'bluePositiveSamples', 'redPositiveSamples');
load('../data/negativeSamples', 'blueNegativeSamples', 'redNegativeSamples');

bluePositiveSamples = double(squeeze(bluePositiveSamples));
redPositiveSamples = double(squeeze(redPositiveSamples));

k = randperm(size(bluePositiveSamples,1)); 
mandatory_positive = bluePositiveSamples(k(:),:);

mandatory_negative = double(squeeze(blueNegativeSamples));
k = randperm(size(mandatory_negative,1)); 
mandatory_negative = mandatory_negative(k(:),:);

k = randperm(size(redPositiveSamples,1)); 
prohibitory_positive = redPositiveSamples(k(:),:);

prohibitory_negative = double(squeeze(redNegativeSamples));
k = randperm(size(prohibitory_negative,1)); 
prohibitory_negative = prohibitory_negative(k(:),:);

danger_positive = prohibitory_positive;
danger_negative = [];

mandatory_SVMModel = f_train_svm(mandatory_positive/255,mandatory_negative/255);
prohibitory_SVMModel = f_train_svm(prohibitory_positive/225,prohibitory_negative/225);
% danger_SVMModel = f_train_svm(danger_positive,danger_negative);

save('../SVMModels/mandatory_SVMModel','mandatory_SVMModel');
save('../SVMModels/prohibitory_SVMModel','prohibitiry_SVMModel');
% save('../SVMModels/danger_SVMModel','danger_SVMModel');
imageRoot = '../files/';




f_apply_svm(mandatory_SVMModel,imageRoot,'../mandatory/');
f_apply_svm( prohibitory_SVMModel, imageRoot,'../prohibitory/');
% f_apply_svm( danger_SVMModel, imageRoot,'../danger');
