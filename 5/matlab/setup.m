params = create_params();
bigmap = imread('aerial_color.jpg');
map = imresize(bigmap, params.resize_factor);