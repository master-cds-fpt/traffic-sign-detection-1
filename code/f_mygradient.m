function [mag,ori] = f_mygradient(I)
%
% compute image gradient magnitude and orientation at each pixel
%
%generate gradient matrices
dy = imfilter(I, [-1; 0; 1], 'same', 'conv');
dx = imfilter(I, [-1 0 1], 'same', 'conv');
dx = double(dx);
dy = double(dy);
mag = sqrt(dx.^2 + dy.^2);
ori = atand(dy./dx);



