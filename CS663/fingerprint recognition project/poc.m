function [poc] = poc(im_f, im_g)
    F = fftshift(fft2(im_f)); G_ = conj(fftshift(fft2(im_g)));
    R_FG = (F./abs(F)).*(G_./abs(G_));
    poc = fftshift(ifft2(R_FG));
end