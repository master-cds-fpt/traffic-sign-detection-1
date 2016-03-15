function f_apply_svm(SVMMOdel,input_path,output_path)
for i = 1:600
	file_name = sprintf('%05d.ppm',i);
	out_file_name = sprintf('%05d',i);
	gtFilePath = strcat(input_path,file_name);
	wtFilePAth = strcat(output_path,out_file_name);
	img = double(imread(gtFilePath));
	H = size(img,1);
	W = size(img,2);
	img = reshape(img,H*W,3);
	label = f_predict_svm(SVMMOdel,img);
	img = reshape(label,H,W);
	size(img)
	figure;
	imagesc(img)
	save(wtFilePAth,'img');
end