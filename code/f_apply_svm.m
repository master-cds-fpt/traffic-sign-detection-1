function img = f_apply_svm(SVMModel,input_path,output_path)
for i = 615:634
	file_name = sprintf('%05d.ppm',i);
	out_file_name = sprintf('%05d',i);
	gtFilePath = strcat(input_path,file_name);
	wtFilePAth = strcat(output_path,out_file_name);
	img = double(imread(gtFilePath));
	H = size(img,1);
	W = size(img,2);
	X = reshape(img,H*W,3);
	[~,score] = predict(SVMModel,X/255);
	label = score(:,2);
	img = reshape(label,H,W);
	img(img<-1)=-1;
	img(img>1)=1;
	figure;
	imagesc(img); colormap gray;

	save(wtFilePAth,'img');
end