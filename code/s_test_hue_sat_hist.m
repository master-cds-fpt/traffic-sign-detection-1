path = '../files/00/00002.ppm';
img = imread(path);


img = imresize(img, [32,32]);
imshow(img);

[features] = f_generate_color_features(img);
