clc;

%% evaluating performance and calculating error rate
images = dir('database\all-fp\*.tif');   %databae of 48 images
matched = 0; mismatched = 0;
for i = 1:48
    input_name = images(i).name;
    input_id = input_name(3);
    input_path = strcat('database\all-fp\', images(i).name);
    match = best_image_index(input_path);
    if input_id == match
        matched = matched + 1;
    end
end
mismatched = 48 - matched;
error_percent = mismatched*100/48;
disp(error_percent);

%% FNMR and FMR
threshold = [0.05, 0.1, 0.2, 0.5, 0.7];
images = dir('database\fp_match\*.tif');   %registered person's fingerprints
FNMR = [];
for t = 1:5
    rate = 0;
    for i = 1:size(images,1)
        input_name = images(i).name;
        input_id = input_name(3);
        input_path = strcat('database\all-fp\', images(i).name);
        match = recognised(input_path, threshold(t));
        if ~match
            rate = rate + 1;
        end
    end
    FNMR = [FNMR, rate];
end

images = dir('database\fp_no_match\*.tif');   %unregistered people's fingerprints
FMR = [];
for t = 1:5
    rate = 0;
    for i = 1:size(images,1)
        input_name = images(i).name;
        input_id = input_name(3);
        input_path = strcat('database\all-fp\', images(i).name);
        match = recognised(input_path, threshold(t));
        if match
            rate = rate + 1;
        end
    end
    FMR = [FMR, rate];
end

%% 
% threshold = [0.05, 0.1, 0.2, 0.5, 0.7];
% FNMR = [0,3,7,8,8];  FMR = [38,1,0,0,0];
x = FNMR*100/8;
y = FMR*100/40;
error = (FMR + FNMR)*100/48; 
figure(); plot(threshold, error);
xlabel("threshold"); ylabel("error%");
figure(); plot(x, y); 
xlabel("FNMR (False Non-Matching Rate) [%]");
ylabel("FMR (False Matching Rate) [%]");

