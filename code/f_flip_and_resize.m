function [ template ] = f_flip_and_resize( template )
    template = imresize(template, [16,16]);
    template = rot90(template, 2);
end

