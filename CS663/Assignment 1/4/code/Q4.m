clear; clc;
J1 = imread('T1.jpg');
J2 = imread('T2.jpg');
dJ1 = double(J1(:));    dJ2 = double(J2(:));
J3  = imrotate(J2+1, 28.5, 'crop');
%Intensities of unoccupied pixels are directly assigned as '0'
dJ3 = double(J3(:));

NCC = [];
JE  = [];
QMI = [];
for theta = -45:1:45
    J4 = imrotate(J3, theta, 'crop');
    dJ4 = double(J4(:));
    idx = dJ4 ~= 0; %only field of view pixels considered
    %correlation coefficient
    fJ1 = dJ1(idx);     fJ4 = dJ4(idx);
    cc = abs(dot(fJ1-mean(fJ1),fJ4-mean(fJ4))/(norm(fJ1-mean(fJ1))*norm(fJ4-mean(fJ4))));
    NCC = [NCC, cc];
    JH = zeros(26, 26);   %Joint Histogram with bin size 10
    for v = 1:numel(fJ4)
        i = floor((fJ1(v))/10)+1;  j = floor((fJ4(v))/10)+1;
        JH(i, j) = JH(i, j) + 1;
    end
    %Normalised Joint Histogram / Joint pmf
    p14 = JH/numel(fJ4);
    je = 0;
    NonZeroIndices = JH ~= 0;   %Indices of non-zero values in JH
    pmf = p14(NonZeroIndices);
    je = -sum(pmf.*log2(pmf));
    JE = [JE, je];
    %Marginal histogram of J1
    p1 = sum(p14, 2);   %Column vector containing sums along row
    %Marginal histogram of J4
    p4 = sum(p14, 1);   %Row vector containing sums along column
    %Quadratic Mutual Information b/w J1 & J4
    qmi = 0;
    for i = 1:26
        for j = 1:26
            qmi = qmi + (p14(i,j) - p1(i)*p4(j))^2;
        end
    end
    QMI = [QMI, qmi];
end
NCC_plot = plot(-45:1:45, NCC, 'm');   xlabel('\theta : -45^o to 45^o');   ylabel('Correlation Coefficient');
JE_plot = plot(-45:1:45, JE , 'b');   xlabel('\theta : -45^o to 45^o');   ylabel('Joint Entropy');
QMI_plot = plot(-45:1:45, QMI, 'r');   xlabel('\theta : -45^o to 45^o');   ylabel('QMI');
%optimal rotation observed in JE vs theta is 29 degrees
J4_opt = imrotate(J3, -29, 'crop');
dJ4_opt = double(J4_opt);
imwrite(J4_opt, 'J4_optimal.jpg');
%Joint Histogram for optimal J4
JH = zeros(26, 26);
for v = 1:numel(dJ1)
    i = floor((dJ1(v))/10)+1;  j = floor((dJ4_opt(v))/10)+1;
    JH(i, j) = JH(i, j) + 1;
end
imagesc(5:10:255, 5:10:255, JH)
colorbar