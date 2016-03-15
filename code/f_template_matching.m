function [x,y,score] = f_template_matching(img,template,threshold)
template = fliplr(flipud(template))
scale = 1.1;
[x,y,score] = sub_scale_matching(img,template,threshold);

for k = 1:22
	img = imresize(img,1/scale);
	[x_,y_,score_] = sub_scale_matching(img,template,threshold);
	x_ = [x_ floor(x_./(scale^k))];
	y_ = [y_ floor(x_./(scale^k))];
	score = [score score_];
end
x = [x x_];
y = [y y_];
end

function [x,y] = sub_scale_matching(img,template,threshold)
H = size(img,1);
W = size(img,2);

R = conv2(img,template,'SAME');
[y,x] = find(R>threshold);
end