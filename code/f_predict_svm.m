function labels = f_predict(X,SVMModel):

[~,score] = predict(SVMModel,X);
score(score=<-1)=-1;
score(score>=1)=1;
labels = score
