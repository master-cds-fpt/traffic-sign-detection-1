function model = f_train_svm(positive_data,negative_data)

data = [positive_data;negative_data];
theclass = ones(size(data,1),1);
theclass(size(positive_data,1):end) = -1;
model = fitcsvm(data3,theclass,'KernelFunction','polynomial','BoxConstraint',Inf,'ClassNames',[-1,1]);

