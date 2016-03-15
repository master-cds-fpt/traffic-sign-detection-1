function labels = f_predict_svm(SVMModel,X)

[~,score] = predict(SVMModel,X);
labels = score(:,2);
% labels
lables(labels<=-1)=-1;
labels(labels>=1)=1;
