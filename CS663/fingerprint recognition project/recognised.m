function [recog] = recognised(test_image_dir, threshold)
    recog = false;
    srcFiles = dir('database\fp_register\*.tif');
    best_blpoc = -10^6;
    k1 = 50;
    k2 = 50;
    input_image = imread(test_image_dir);
    for i = 1:size(srcFiles,1)
        filename = strcat('database\fp_register\',srcFiles(i).name);
        registered_image = imread(filename);
%         input_singular = walking(input_image);
%         registered_singular = walking(registered_image);
        input_core = walking(input_image).core;
        registered_core = walking(registered_image).core;
        registered_translated = alignment_translation(filename, registered_core, input_core);
%         disp(i);
        registered_rotated = alignment_rotation(registered_translated, input_core, test_image_dir, k1, k2);        
        % Common region extraction code starts here
        [t, b, l, r] = segment(registered_rotated, 0.2);        
        registered_final = registered_rotated(t:b, l:r);       
        input_final = input_image(t:b, l:r);
%         imshow(input_final);    figure();    imshow(registered_final);
        new_blpoc = blpoc(registered_final, input_final, k1, k2);      
        if (new_blpoc > best_blpoc)  
            best_blpoc = new_blpoc;            
            if best_blpoc > threshold
                recog = true;
            end    
        end
    end
end