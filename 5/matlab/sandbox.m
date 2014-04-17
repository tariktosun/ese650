RGB = imread('ngc6543a.jpg');
figure('Name','RGB Image')
imagesc(RGB)
axis image
zoom(4)
%
[IND,map] = rgb2ind(RGB,32);
figure('Name','Indexed image with 32 Colors')
imagesc(IND)
colormap(map)
axis image
zoom(4)
%%
[ind, cmap] = rgb2ind(map,32);
figure();
imagesc(ind);