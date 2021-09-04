%% MyMainScript
% Your code here 
% 5a
img1 = imread("..\images\goi1.jpg");
img2 = imread("..\images\goi2_downsampled.jpg");
figure;
imshow(img1)
figure;
imshow(img2)

disp(size(img2))

for i=1:12
    figure(1);
    imshow(img1);
    [x1(i), y1(i)] = ginput(1);
    figure(2);
    imshow(img2);
    [x2(i), y2(i)] = ginput(1);
end

I1 = ones(3, 12); I2 = ones(3, 12);

I1(1, :) = x1(:);
I1(2, :) = y1(:);
I2(1, :) = x2(:);
I2(2, :) = y2(:);

%% 5b
temp = I2*pinv(I1);
disp(temp);

%% 5c
final_1 = zeros(360, 640);
affine = inv(temp);
for i = 1:360
    for j = 1:640
        T = affine*[i; j; 1];
        T = [T(1) T(2)];
        
        a1 = [floor(T(1)) ceil(T(2))];
        a2 = [ceil(T(1)) ceil(T(2))];
        a3 = [ceil(T(1)) floor(T(2))];
        a4 = [floor(T(1)) floor(T(2))];
        
        d1 = norm(a1-T);
        d2 = norm(a2-T);
        d3 = norm(a3-T);
        d4 = norm(a4-T);
        
        closest = min([d1, d2, d3, d4]);
        
        if(closest==d1) 
            img_point = a1;
        elseif(closest==d2)
            img_point = a2;
        elseif(closest==d3)
            img_point = a3;
        else
            img_point = a4;
        end
        
        if((0<img_point(1) && img_point(1)<=360) && (0<img_point(2) && img_point(2)<=640))
            final_1(i, j) = img1(img_point(1), img_point(2));
        end
    end
end
figure;
imshow(final_1, [0, 255]);

%% 5d
final_2 = zeros(360, 640);
for i=1:360
    for j=1:640
        T = affine*[i; j; 1];
        T = [T(1) T(2)];
        
        if((1<=T(1) && T(1)<=360) && (1<=T(2) && T(2)<=640))
            a1 = [floor(T(1)) ceil(T(2))];
            a2 = [ceil(T(1)) ceil(T(2))];
            a3 = [ceil(T(1)) floor(T(2))];
            a4 = [floor(T(1)) floor(T(2))];
            
            A = (T(1)-a1(1))*(a1(2)-T(2));
            B = (a2(1)-T(1))*(a2(2)-T(2));
            C = (a3(1)-T(1))*(T(2)-a3(2));
            D = (T(1)-a4(1))*(T(2)-a4(2));
            
            final_2(i, j) = (A*img1(a3(1), a3(2)))+(B*img1(a4(1), a4(2)))+(C*img1(a1(1), a1(2)))+(D*img1(a2(1), a2(2)));
        else
            final_2(i, j) = 0;
        end
    end
end
figure;
imshow(final_2, [0, 255]);
