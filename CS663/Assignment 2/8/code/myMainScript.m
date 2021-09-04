%% MyMainScript % reading Data
clear;
clc;
img1 = double(imread("..\images\barbara256.png"));
img2 = double(imread("..\images\kodak24.png"));

%% Adding Noise
% variance = sigma^2
img1_noise1 = GaussianNoise(img1, 0, 5); 
img1_noise2 = GaussianNoise(img1, 0, 10);
img2_noise1 = GaussianNoise(img2, 0, 5);
img2_noise2 = GaussianNoise(img2, 0, 10);

%% Instance Variables
% sigma_s and sigma_r values
sigma_sr = [2 2; 0.1 0.1; 3 15];

BF_img1_1 = zeros(256, 256, 3);
BF_img1_2 = zeros(256, 256, 3);
BF_img2_1 = zeros(512, 768, 3);
BF_img2_2 = zeros(512, 768, 3);

%% Actual Program Logic
for i = 1:3
    BF_img1_1(:, :, i) = mybilateralfilter(img1_noise1, sigma_sr(i, 1), sigma_sr(i, 2));
    BF_img1_2(:, :, i) = mybilateralfilter(img1_noise2, sigma_sr(i, 1), sigma_sr(i, 2));
    BF_img2_1(:, :, i) = mybilateralfilter(img2_noise1, sigma_sr(i, 1), sigma_sr(i, 2));
    BF_img2_2(:, :, i) = mybilateralfilter(img2_noise2, sigma_sr(i, 1), sigma_sr(i, 2));
end

%% Displaying all our results
% Original Images
figure; imshow(img1, [0 255]);
figure; imshow(img2, [0 255]);

%%
% Images with different noises
figure; imshow(img1_noise1, [0 255]);
figure; imshow(img1_noise2, [0 255]);
figure; imshow(img2_noise1, [0 255]);
figure; imshow(img2_noise2, [0 255]);

%%
% Various parameters of sigma_s and sigma_r for the images:
for i=1:3
    figure; imshow(BF_img1_1(:, :, i), [0 255]);
    figure; imshow(BF_img1_2(:, :, i), [0 255]);
    figure; imshow(BF_img2_1(:, :, i), [0 255]);
    figure; imshow(BF_img2_2(:, :, i), [0 255]);
end