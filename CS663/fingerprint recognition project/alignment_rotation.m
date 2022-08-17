function [im2] = alignment_rotation(register_transformed, input_core, input_path, k1, k2)
    input_image = imread(input_path);
    best_blpoc = -10^8;
    best_theta = -40;
    for angle = -40:40
        T1 = [1 0 0; 0 1 0; -input_core(1) -input_core(2) 1];
        T2 = [1 0 0; 0 1 0; input_core(1) input_core(2) 1];
        R = [cosd(angle) sind(angle) 0; -sind(angle) cosd(angle) 0; 0 0 1];
        T = T1*R*T2;
        tform_t = affine2d(T);
        sameAsInput = affineOutputView(size(input_image),tform_t,'BoundsStyle','SameAsInput');
        rotated_image = imwarp(register_transformed, tform_t,'OutputView',sameAsInput);
        new_blpoc = blpoc(rotated_image, input_image, k1, k2);
        if (new_blpoc > best_blpoc)
            best_blpoc = new_blpoc;
            best_theta = angle;
        end
    end
    angle = best_theta;    
    T1 = [1 0 0; 0 1 0; -input_core(1) -input_core(2) 1];
    T2 = [1 0 0; 0 1 0; input_core(1) input_core(2) 1];
    R = [cosd(angle) sind(angle) 0; -sind(angle) cosd(angle) 0; 0 0 1];
    T = T1*R*T2;
    tform_t = affine2d(T);
    sameAsInput = affineOutputView(size(input_image),tform_t,'BoundsStyle','SameAsInput');
    im2 = imwarp(register_transformed, tform_t,'OutputView',sameAsInput);
    
end
