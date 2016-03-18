%prohibitory vs mandatory model
pvsmModel = f_train_recognition_svm(prohibitoryFeatures, mandatoryFeatures, 'pr', 'ma');

%prohibitory vs danger model
pvsdModel = f_train_recognition_svm(prohibitoryFeatures, dangerFeatures, 'pr', 'da');

%mandatory vs danger model
mvsdModel = f_train_recognition_svm(mandatoryFeatures, dangerFeatures, 'ma', 'da');

%prohibitory vs other model
pvsoModel = f_train_recognition_svm(prohibitoryFeatures, otherFeatures, 'pr', 'ot');

%mandatory vs other model
mvsoModel = f_train_recognition_svm(mandatoryFeatures, otherFeatures, 'ma', 'ot');

%danger vs other model
dvsoModel = f_train_recognition_svm(dangerFeatures, otherFeatures, 'da', 'ot');

save('../data/recognitonModels', 'pvsmModel' ,'pvsdModel', 'mvsdModel', 'pvsoModel', 'mvsoModel', 'dvsoModel');

%[a,b] = predict(pvsmModel, mandatoryFeatures);

