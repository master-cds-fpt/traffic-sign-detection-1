function f_apply_svm(SVMModel,input_path,output_path)
for i = 1:600
	file_name = sprintf('%05d.ppm',i);
	out_file_name = sprintf('%05d',i);
	gtFilePath = strcat(input_path,file_name);
	wtFilePAth = strcat(output_path,out_file_name);
	img = double(imread(gtFilePath));
	H = size(img,1);
	W = size(img,2);
	X = reshape(img,H*W,3);
	[~,score] = predict(SVMModel,X);
	label = score(:,2);
	label(label<-1)=-1;
	label(label>1)=1;
	img = reshape(label,H,W);
	save(wtFilePAth,'img');
end