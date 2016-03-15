load('../data/positiveSamples', 'bluePositiveSamples', 'redPositiveSamples');
bluePositiveSamples = squeeze(bluePositiveSamples);
redPositiveSamples = squeeze(redPositiveSamples);

k = randperm(size(bluePositiveSamples,1)); 
mandatory_positive = bluePositiveSamples(k(1:15000),:);
mandatory_negative = [];

k = randperm(size(redPositiveSamples,1)); 
prohibitory_positive = redPositiveSamples(k(1:15000),:);
prohibitory_negative = mandatory_negative;

danger_positive = prohibitory_positive;
danger_negative = [];

mandatory_SVMModel = f_train_svm(mandatory_positive,mandatory_negative);
prohibitiry_SVMModel = f_train_svm(prohibitory_positive,prohibitory_negative);
danger_SVMModel = f_train_svm(danger_positive,danger_negative);

imageRoot = '../files/';

f_apply_svm( mandatory_SVMModel, imageRoot,'../mandatory');
f_apply_svm( prohibitiry_SVMModel, imageRoot,'../prohibitory')
f_apply_svm( danger_SVMModel, imageRoot,'../danger');
