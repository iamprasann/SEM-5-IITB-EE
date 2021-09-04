clear; clc;
I1 = imread('LC1.jpg');
I2 = imread('LC2.jpg');

I1_7 = local_hist_eq(I1,7,7);
imshow(I1_7, [0, 255]);
I1_31 = local_hist_eq(I1,31,31);
imshow(I1_31, [0, 255]);
I1_51 = local_hist_eq(I1,51,51);
imshow(I1_51, [0, 255]);
I1_71 = local_hist_eq(I1,71,71);
imshow(I1_71, [0, 255]);
I2_7 = local_hist_eq(I2,7,7);
imshow(I2_7, [0, 255]);
I2_31 = local_hist_eq(I2,31,31);
imshow(I2_31, [0, 255]);
I2_51 = local_hist_eq(I2,51,51);
imshow(I2_51, [0, 255]);
I2_71 = local_hist_eq(I2,71,71);
imshow(I2_71, [0, 255]);

I1_h = histeq(I1, 256);
I2_h = histeq(I2, 256);
imwrite(I1_h, 'LC1_global_histeq.jpg');
imwrite(I2_h, 'LC2_global_histeq.jpg');

function S = local_hist_eq(I, h, k)
    H = size(I, 1); B = size(I, 2);
    S = zeros(H, B);
    for x = 1:H
        for y = 1:B
            S(x,y) = transform(I, x, y, h, k);
        end
    end
end

function s = transform(I, x, y, h, k)
    im = [];
    H = size(I, 1); B = size(I, 2);
    r = floor(h/2); c = floor(k/2);
    i = double(0); j = double(0);
    for i = x-r:x+r
        for j = y-c:y+c
            if i <= 0 || j <= 0 || i > H || j > B
                im = [im, 0];
            else
                im = [im, I(i,j)];
            end
        end
    end
    l = 256;
    s = cdf(im, I(x,y))*(l-1);
end

function p = cdf(I, r)
    d = I(:); k = 0;
    for i = 1:numel(I)
        if d(i) <= r
            k = k + 1;
        end
    end
    p = k/numel(I);
end

    
    
    
    
