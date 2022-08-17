
filenamer = strcat('database\registered-fp\','106_4.tif');

filenamei = strcat('database\all-fp\','106_8.tif');

input_image = imread(filenamei);
registered_image = imread(filenamer);

detectedsp1 = walking(input_image);
detectedsp2 = walking(registered_image);

input_core = detectedsp1.core;
registered_core = detectedsp2.core;
k1 = 50;
k2 = 50;
im2 = alignment_translation(filenamer, registered_core, input_core);
im3 = alignment_rotation(im2, input_core, filenamei, k1, k2);
%%
clc;
[t, b, l, r] = segment(im3, 0.5);
im4 = im3(t:b, l:r);
im5 = input_image(t:b, l:r);
subplot(2,3,1), imshow(input_image); title("Input Image");
subplot(2,3,2), imshow(registered_image);  title("Reference Image");
subplot(2,3,3), imshow(im2);  title("Translated Reference Image");
subplot(2,3,4), imshow(im3);  title("Rotated and Translated Reference Image");
subplot(2,3,5), imshow(im4);  title("register");
subplot(2,3,6), imshow(im5);  title("input");
