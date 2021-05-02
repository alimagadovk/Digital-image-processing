%% task 1
clc
clear
close all

I = imread('spine.tif');
J1 = imadjust(I, [0 1], [1 0]);
J2 = imadjust(J1, [194/255 198/255], [0 1]);
figure
imshow(I)
figure
imshow(J1)
figure
imshow(J2)
%% task 2
clc
clear
close all

im = imread('1.gif');
S = fftshift(fft2(im));


figure
imshow(im)
figure
imshow(uint8(abs(S)))
figure
imshow(uint8(15*log(1 + abs(S))))

%imwrite(uint8(abs(S)), 'task2_spectr.png', 'png')
%imwrite(uint8(15*log(1 + abs(S))), 'task2_spectr_log.png', 'png')
%% task 3
clc
clear
close all

I = imread('pout.tif');
I1 = imadjust(I, [], [0 0.5]);
I2 = imadjust(I, [], [0.5 1]);

figure
imshow(I)
figure
imhist(I)

figure
imshow(I1)
figure
imhist(I1)

figure
imshow(I2)
figure
imhist(I2)

J1 = histeq(I1);
J2 = histeq(I2);
figure
imshow(J1)
figure
imhist(J1)

figure
imshow(J2)
figure
imhist(J2)

% imwrite(I, 'task3_original_im.png', 'png')
% imwrite(I1, 'task3_dark_im.png', 'png')
% imwrite(I2, 'task3_light_im.png', 'png')
% imwrite(J1, 'task3_eq_dark_im.png', 'png')
% imwrite(J2, 'task3_eq_light_im.png', 'png')
%% task 4
clc
clear
close all

I = imread('moon.tif');
figure
imshow(I)

mask1 = fspecial('average', 3);
J1 = imfilter(I, mask1, 'symmetric');
figure
imshow(uint8(J1))

mask2 = fspecial('average', 5);
J2 = imfilter(I, mask2, 'symmetric');
figure
imshow(uint8(J2))

lapl = fspecial('laplacian', 0.5);
mask3 = [0, 0, 0;
         0, 1, 0;
         0, 0, 0];

J3 = imfilter(J1, mask3 - lapl, 'symmetric');
figure
imshow(uint8(J3))


J4 = imfilter(J2, mask3 - lapl, 'symmetric');
figure
imshow(uint8(J4))

% imwrite(I, 'task4_original_im.png', 'png')
% imwrite(J1, 'task4_avr_3x3.png', 'png')
% imwrite(J2, 'task4_avr_5x5.png', 'png')
% imwrite(J3, 'task4_avr_3x3_lapl.png', 'png')
% imwrite(J4, 'task4_avr_5x5_lapl.png', 'png')
%% task 5
clc
clear
close all

I = imread('rice.png');
figure
imshow(I)

J_sob_x = imfilter(I, fspecial('sobel'), 'symmetric');


J_sob_y = imfilter(I, fspecial('sobel')', 'symmetric');

figure
imshow(sqrt(double(J_sob_x.^2 + J_sob_y.^2)))

figure
imshow(imadjust(sqrt(double(J_sob_x.^2 + J_sob_y.^2)), [], [1 0]))

figure
imshow(abs(J_sob_x) + abs(J_sob_y))

figure
imshow(imadjust(abs(J_sob_x) + abs(J_sob_y), [], [1 0]))



dfdx = [-1 0; 0 1];
dfdy = [0 -1; 1 0];
J_rob_x = imfilter(I, dfdx, 'symmetric');
J_rob_y = imfilter(I, dfdx, 'symmetric');

figure
imshow(sqrt(double(J_rob_x.^2 + J_rob_y.^2)))

figure
imshow(imadjust(sqrt(double(J_rob_x.^2 + J_rob_y.^2)), [], [1 0]))

figure
imshow(abs(J_rob_x) + abs(J_rob_y))

figure
imshow(imadjust(abs(J_rob_x) + abs(J_rob_y), [], [1 0]))

% imwrite(I, 'task5_original_im.png', 'png')
% imwrite(sqrt(double(J_sob_x.^2 + J_sob_y.^2)), 'task5_sob_sqrt.png', 'png')
% imwrite(imadjust(sqrt(double(J_sob_x.^2 + J_sob_y.^2)), [], [1 0]), 'task5_sob_sqrt_neg.png', 'png')
% imwrite(abs(J_sob_x) + abs(J_sob_y), 'task5_sob_abs.png', 'png')
% imwrite(imadjust(abs(J_sob_x) + abs(J_sob_y), [], [1 0]), 'task5_sob_abs_neg.png', 'png')
% imwrite(sqrt(double(J_rob_x.^2 + J_rob_y.^2)), 'task5_rob_sqrt.png', 'png')
% imwrite(imadjust(sqrt(double(J_rob_x.^2 + J_rob_y.^2)), [], [1 0]), 'task5_rob_sqrt_neg.png', 'png')
% imwrite(abs(J_rob_x) + abs(J_rob_y), 'task5_rob_abs.png', 'png')
% imwrite(imadjust(abs(J_rob_x) + abs(J_rob_y), [], [1 0]), 'task5_rob_abs_neg.png', 'png')
%% task 6
clc
clear
close all

I = imread('Lena.png');
figure
imshow(I)

J_sob_x = imfilter(I, fspecial('sobel'), 'symmetric');


J_sob_y = imfilter(I, fspecial('sobel')', 'symmetric');

figure
imshow(abs(J_sob_x) + abs(J_sob_y))

figure
imshow(imadjust(abs(J_sob_x) + abs(J_sob_y), [], [1 0]))

% imwrite(abs(J_sob_x) + abs(J_sob_y), 'task6_res.png', 'png')
% imwrite(imadjust(abs(J_sob_x) + abs(J_sob_y), [], [1 0]), 'task6_neg.png', 'png')
%% task 7
clc
clear
close all

I_rgb = imread('tuman.png');
I_ycbcr = rgb2ycbcr(I_rgb);
I_hsi = rgb2hsi(I_rgb);

% figure
% imshow(I_rgb)
% 
% figure
% imshow(I_ycbcr)
% 
% figure
% imshow(I_hsi)

% à)

for i = 1:3
    J_rgb(:,:,i) = imadjust(I_rgb(:,:,i));
    J_ycbcr(:,:,i) = imadjust(I_ycbcr(:,:,i));
    J_hsi(:,:,i) = imadjust(I_hsi(:,:,i));
end

figure
imshow(J_rgb)

figure
imshow(ycbcr2rgb(J_ycbcr))

figure
imshow(hsi2rgb(J_hsi))

% imwrite(J_rgb, 'task7_a_rgb.png', 'png')
% imwrite(ycbcr2rgb(J_ycbcr), 'task7_a_ycbcr.png', 'png')
% imwrite(hsi2rgb(J_hsi), 'task7_a_hsi.png', 'png')

% á)

J_ycbcr = I_ycbcr;
J_ycbcr(:,:,1) = imadjust(I_ycbcr(:,:,1));

figure
imshow(ycbcr2rgb(J_ycbcr))

%imwrite(ycbcr2rgb(J_ycbcr), 'task7_b.png', 'png')

% â)

J_hsi = I_hsi;
J_hsi(:,:,3) = imadjust(I_hsi(:,:,3));

figure
imshow(hsi2rgb(J_hsi))

%imwrite(hsi2rgb(J_hsi), 'task7_c_I.png', 'png')

J_hsi(:,:,2) = imadjust(I_hsi(:,:,2));

figure
imshow(hsi2rgb(J_hsi))

%imwrite(hsi2rgb(J_hsi), 'task7_c_IS.png', 'png')

%%
clc
clear
close all

I_rgb = imread('Lena_c.png');
I_hsi = rgb2hsi(I_rgb);

figure
imshow(I_rgb)

mask = [0, 0, 0; 0, 1, 0; 0, 0, 0];

for i = 1:3
    J_rgb(:,:,i) = imfilter(I_rgb(:,:,i), mask - fspecial('laplacian',0), 'symmetric');
end

J_hsi = I_hsi;

J_hsi(:,:,3) = imfilter(I_hsi(:,:,3), mask - fspecial('laplacian',0), 'symmetric');

figure
imshow(J_rgb)

figure
imshow(hsi2rgb(J_hsi))

%imwrite(J_rgb, 'task7_d_rgb.png', 'png')
%imwrite(hsi2rgb(J_hsi), 'task7_d_hsi.png', 'png')

ssim(I_rgb,J_rgb)
ssim(I_rgb,uint8(255*hsi2rgb(J_hsi)))
