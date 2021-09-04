function [im_BF] = mybilateralfilter(img, s_s, s_r)
    [rows, cols] = size(img);
    im_BF = zeros(rows, cols);
    a = ceil(ceil(6*s_s)/2.0);    %window size is (2a+1)x(2a+1) and 2a+1 = 6sigma_s+1
    
    for i = 1:rows
        for j = 1:cols            
            %Indexing matrices, to act as a work around for zero padding
            u = max([1, i-a]); d = min([rows, i+a]);
            l = max([1, j-a]); r = min([cols, j+a]);
            
            %Creating I_q (window of filter) and G_sigma_r and G_sigma_s
            y = l:r; x = u:d; I_q = img(x, y); 
            G_r = (I_q-img(i, j)).^2; G_r = cast(G_r, 'double');
            G_r = exp((-G_r)/(2.0*(s_r*s_r)));
            I_q = cast(I_q, 'double');
            
            [X, Y] = meshgrid(x, y); G = (X-i).^2 + (Y-j).^2;
            G_s = exp((-G)/(2.0*(s_s*s_s)));
            G_s = transpose(G_s); G_s = cast(G_s, 'double');

            product_num = sum(G_s .* G_r .* I_q, 'all');    
            product_den = sum(G_s .* G_r, 'all');      
            im_BF(i, j) = cast(product_num/product_den, 'uint8');
        end
    end
end 