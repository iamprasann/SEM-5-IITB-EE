function [best_image_id] = best_image_index(test_image_dir)
    srcFiles = dir('database\registered-fp\*.tif');
    best_blpoc = -10^6;
    k1 = 50;
    k2 = 50;
    input_image = imread(test_image_dir);
    for i = 1:7
        filename = strcat('database\all-fp\',srcFiles(i).name);
        registered_image = imread(filename);
%         input_singular = walking(input_image);
%         registered_singular = walking(registered_image);
        input_core = walking(input_image).core;
        registered_core = walking(registered_image).core;
        registered_translated = alignment_translation(filename, registered_core, input_core);
%         disp(i);
        registered_rotated = alignment_rotation(registered_translated, input_core, test_image_dir, k1, k2);
        [t, b, l, r] = segment(registered_rotated, 0.2);        
        registered_final = registered_rotated(t:b, l:r);       
        input_final = input_image(t:b, l:r);
        imshow(input_final);    figure();    imshow(registered_final);
        new_blpoc = blpoc(registered_final, input_final, k1, k2);      
        if (new_blpoc > best_blpoc)  
            best_blpoc = new_blpoc;
            best_image_id = srcFiles(i).name(3);            
        end
%         a = blpoc(registered_final, input_final, k1, k2);
%         figure();
%         surfl(fftshift(a))
%         colormap(pink)    % change color map
%         shading interp           
          
%         figure();
%         subplot(2,3,1), imshow(input_image); title("Input Image");
%         subplot(2,3,2), imshow(registered_image);  title("Reference Image");
%         subplot(2,3,3), imshow(registered_translated);  title("Translated Reference Image");
%         subplot(2,3,4), imshow(registered_rotated);  title("Rotated and Translated Reference Image");
%         subplot(2,3,5), imshow(input_final);  title("input");
%         subplot(2,3,6), imshow(registered_final);  title("registered");
    end
end