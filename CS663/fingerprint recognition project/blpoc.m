function [blpoc] = blpoc(im_f, im_g, k1, k2)
    l1 = 2*k1+1;
    l2 = 2*k2+1;
    F = fft2(im_f);
    [rows,cols] = size(F);
    F = fftshift(F);
    G_ = conj(fftshift(fft2(im_g)));
    R_FG = (F.*G_)./abs(F.*G_);
    m1 = rows/2; m2 = cols/2;
    t = m1 - k1;    b = 2*m1 - t;
    l = m2 - k2;    r = 2*m2 - l;
    fft_blpoc = R_FG(t:b, l:r);
    blpoc = ifft2(ifftshift(fft_blpoc));
    blpoc = abs(blpoc);
    mat = blpoc(:);
    blpoc = sum(maxk(mat, 2)); %sum of 2 highest peaks
end