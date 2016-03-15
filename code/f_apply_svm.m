function f_apply_svm(SVMMOdel,input_path,output_path)
for i = 1:600
	file_name = sprintf('%05d.ppm',1);
	gtFilePath = strcat(input_path,file_name);
	wtFilePAth = strcat(output_path,file_name);
	img = imread(gtFilePath);
	H = size(img,1);
	W = size(img,2);
	img = reshape(img,H*W,3);
	label = f_predict_svm(SVMMOdel,img);
	img = reshape(label,H,W);
	imwrite(img,wtFilePAth);
end