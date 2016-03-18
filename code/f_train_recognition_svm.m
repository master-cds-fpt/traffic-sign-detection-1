function model = f_train_recognition_svm(positive_data,negative_data, label1, label2)

data = [positive_data;negative_data];
theclass = repmat({label1}, [size(data,1),1]);
theclass(size(positive_data,1)+1:end,:) = {label2};   
costMatrix = [0, 10; 10, 0];
model = fitcsvm(data,theclass,'KernelFunction','rbf', 'KernelScale', 0.1, 'Cost', costMatrix, 'ClassNames',{label1,label2});
