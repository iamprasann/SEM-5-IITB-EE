
filenamer = strcat('database\registered-fp\','103_3.tif');
filenamei = strcat('database\all-fp\','106_8.tif');

input_image = imread(filenamei);
registered_image = imread(filenamer);

detectedsp1 = walking(input_image);
detectedsp2 = walking(registered_image);

input_core = detectedsp1.core;
registered_core = detectedsp2.core;
k1 = 50;
k2 = 50;
registered_translated = alignment_translation(filenamer, registered_core, input_core);
registered_rotated = alignment_rotation(registered_translated, input_core, filenamei, k1, k2);
[t, b, l, r] = segment(registered_rotated, 0.2);        
registered_final = registered_rotated(t:b, l:r);       
input_final = input_image(t:b, l:r);

% subplot(2,2,2), imshow(input_image); title("Input Image"); hold on;
% plot(input_core(1), input_core(2), 'ro', 'markersize',12,'linewidth',2);
% subplot(2,2,1), imshow(registered_image);  title("Reference Image"); hold on;
% plot(registered_core(1), registered_core(2), 'ro', 'markersize',12,'linewidth',2);
% subplot(2,2,3), imshow(im2);  title("Translated Reference Image");
% subplot(2,2,4), imshow(im3);  title("Rotated and Translated Reference Image");

%% Display Demo
subplot(2,3,1), imshow(input_image); title("Input Image"); hold on;
plot(input_core(1), input_core(2), 'ro', 'markersize',12,'linewidth',2);
subplot(2,3,2), imshow(registered_image);  title("Reference Image"); hold on;
plot(registered_core(1), registered_core(2), 'ro', 'markersize',12,'linewidth',2);
subplot(2,3,3), imshow(registered_translated);  title("Translated Reference Image");
subplot(2,3,4), imshow(registered_rotated);  title("Rotated and Translated Reference Image");
subplot(2,3,5), imshow(input_final);  title("input");
subplot(2,3,6), imshow(registered_final);  title("registered");