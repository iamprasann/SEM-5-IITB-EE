function [im_noisy] = GaussianNoise(img, u, sigma)
    [rows, cols] = size(img);
    im_noisy = img + normrnd(u, sigma, [rows, cols]);
end