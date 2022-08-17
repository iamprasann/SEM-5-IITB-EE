function [im2] = alignment_translation(register_path, register_core, input_core)
    register_image = imread(register_path);
    T = [1 0 0;0 1 0;(input_core(1) - register_core(1)) (input_core(2) - register_core(2)) 1];
    tform_t = affine2d(T);
    sameAsInput = affineOutputView(size(register_image),tform_t,'BoundsStyle','SameAsInput');
    im2 = imwarp(register_image, tform_t, 'OutputView',sameAsInput);
end
