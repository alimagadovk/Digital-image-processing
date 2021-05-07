clc
clear
close all


im = imread('task1_im.png');
im_n1 = imread('task1_im_gauss_noise.png');
im_n2 = imread('task1_im_salt&pepper_noise.png');

im = double(im);
im_n1 = double(im_n1);
im_n2 = double(im_n2);

SNR_gauss_1 = snr(im,im_n1 - im);
SNR_sp_1 = snr(im,im_n2 - im);
SSIM_gauss_1 = ssim(uint8(im),uint8(im_n1));
SSIM_sp_1 = ssim(uint8(im),uint8(im_n2));

sigma_n2 = 0.01;
m = 3;
n = 3;
[M, N] = size(im);
im_res1 = adapt_filt(im_n1, sigma_n2*M*N/(m*n), m, n);
sigma_n2 = var(im_n2(:)) - var(im(:));
m = 3;
n = 3;
im_res2 = adapt_filt(im_n2, sigma_n2/(m*n), m, n);


figure
imshow(uint8(im_n1))

figure
imshow(uint8(im_n2))

figure
imshow(uint8(im_res1))

figure
imshow(uint8(im_res2))


SNR_gauss_2 = snr(im,im_res1 - im);
SNR_sp_2 = snr(im,im_res2 - im);
SSIM_gauss_2 = ssim(uint8(im),uint8(im_res1));
SSIM_sp_2 = ssim(uint8(im),uint8(im_res2));

disp('SNR_gauss_noise (' + string(SNR_gauss_1) + '/' + string(SNR_gauss_2) + ')')
disp('SNR_sp_noise (' + string(SNR_sp_1) + '/' + string(SNR_sp_2) + ')')
disp('SSIM_gauss_noise (' + string(SSIM_gauss_1) + '/' + string(SSIM_gauss_2) + ')')
disp('SSIM_sp_noise (' + string(SSIM_sp_1) + '/' + string(SSIM_sp_2) + ')')

% imwrite(uint8(im_res1), 'task1_im_gauss_adapt_filt.png', 'png')
% imwrite(uint8(im_res2), 'task1_im_salt&pepper_adapt_filt.png', 'png')
%% task 2
clc
close all

Smax = 3;
im_res1 = adpmedian(im_n1, Smax);
im_res2 = adpmedian(im_n2, Smax);

figure
imshow(uint8(im_n1))

figure
imshow(uint8(im_n2))

figure
imshow(uint8(im_res1))

figure
imshow(uint8(im_res2))

SNR_gauss_2 = snr(im,im_res1 - im);
SNR_sp_2 = snr(im,im_res2 - im);
SSIM_gauss_2 = ssim(uint8(im),uint8(im_res1));
SSIM_sp_2 = ssim(uint8(im),uint8(im_res2));

disp('SNR_gauss_noise (' + string(SNR_gauss_1) + '/' + string(SNR_gauss_2) + ')')
disp('SNR_sp_noise (' + string(SNR_sp_1) + '/' + string(SNR_sp_2) + ')')
disp('SSIM_gauss_noise (' + string(SSIM_gauss_1) + '/' + string(SSIM_gauss_2) + ')')
disp('SSIM_sp_noise (' + string(SSIM_sp_1) + '/' + string(SSIM_sp_2) + ')')

%imwrite(uint8(im_res1), 'task2_im_gauss_adaptmed_filt.png', 'png')
%imwrite(uint8(im_res2), 'task2_im_salt&pepper_adaptmed_filt.png', 'png')
%% task 3
clc
close all

im_res1 = bilateral_filter1(im_n1,3,1.2,55);
im_res2 = bilateral_filter1(im_n2,3,0.65,255);

figure
imshow(uint8(im_n1))

figure
imshow(uint8(im_n2))

figure
imshow(uint8(im_res1))

figure
imshow(uint8(im_res2))

SNR_gauss_2 = snr(im,im_res1 - im);
SNR_sp_2 = snr(im,im_res2 - im);
SSIM_gauss_2 = ssim(uint8(im),uint8(im_res1));
SSIM_sp_2 = ssim(uint8(im),uint8(im_res2));

disp('SNR_gauss_noise (' + string(SNR_gauss_1) + '/' + string(SNR_gauss_2) + ')')
disp('SNR_sp_noise (' + string(SNR_sp_1) + '/' + string(SNR_sp_2) + ')')
disp('SSIM_gauss_noise (' + string(SSIM_gauss_1) + '/' + string(SSIM_gauss_2) + ')')
disp('SSIM_sp_noise (' + string(SSIM_sp_1) + '/' + string(SSIM_sp_2) + ')')

%imwrite(uint8(im_res1), 'task3_im_gauss_bilat_filt.png', 'png')
%imwrite(uint8(im_res2), 'task3_im_salt&pepper_bilat_filt.png', 'png')
%% task 4
clc
close all

spectr1 = fftshift(fft2(im_n1));
spectr2 = fftshift(fft2(im_n2));

Sg1 = spectr1.*conj(spectr1);
Sg2 = spectr2.*conj(spectr2);

%Sn1 = 0.01*M*N;
%Sn2 = var(im_n2(:)) - var(im(:));
Sn1 = 220000000;
Sn2 = 210000000;


W1 = 1 - Sn1./Sg1;
W2 = 1 - Sn2./Sg2;

mas1 = find(W1 < 0);
mas2 = find(W2 < 0);

W1(mas1) = 0;
W2(mas2) = 0;


W1(M/2 + 1,N/2 + 1) = 1;
W2(M/2 + 1,N/2 + 1) = 1;

im_res1 = abs(ifft2(ifftshift(W1.*spectr1)));
im_res2 = abs(ifft2(ifftshift(W2.*spectr2)));


figure
imshow(uint8(im_n1))

figure
imshow(uint8(im_n2))

figure
imshow(uint8(im_res1))

figure
imshow(uint8(im_res2))

SNR_gauss_2 = snr(im,im_res1 - im);
SNR_sp_2 = snr(im,im_res2 - im);
SSIM_gauss_2 = ssim(uint8(im),uint8(im_res1));
SSIM_sp_2 = ssim(uint8(im),uint8(im_res2));


disp('SNR_gauss_noise (' + string(SNR_gauss_1) + '/' + string(SNR_gauss_2) + ')')
disp('SNR_sp_noise (' + string(SNR_sp_1) + '/' + string(SNR_sp_2) + ')')
disp('SSIM_gauss_noise (' + string(SSIM_gauss_1) + '/' + string(SSIM_gauss_2) + ')')
disp('SSIM_sp_noise (' + string(SSIM_sp_1) + '/' + string(SSIM_sp_2) + ')')

%imwrite(uint8(im_res1), 'task4_im_gauss_w.png', 'png')
%imwrite(uint8(im_res2), 'task4_im_salt&pepper_w.png', 'png')
%% task 5
clc
%clear
close all
im = imread('task1_im.png');

im = double(im);
[M, N] = size(im);
n = 1;
u0 = (-1)^n*(0.3*M/n) - 0.5;
v0 = -0.75*u0;

C = [u0 v0]; % координаты частот, составляющих гарм. помехи на спектре относительно центра изображения
A(1:size(C,1)) = [70]; % амплтитуды составл. гарм. помехи
[r, R, S] = MyGarmNoise(512, 512, C, A);
im_n = real(im + r);

SNR_1 = snr(im,im_n - im);
MSE_1 = sum(sum((im - im_n).^2)) / (size(im,1) * size(im,2));
PSNR_1 = 20*log(255/sqrt(MSE_1))/log(10);
SSIM_1 = ssim(uint8(im),uint8(im_n));

D0 = 26;
h = Gauss_filt(M,N,D0,u0,v0);

spectr = fftshift(fft2(im_n));

spectr_n = spectr .* h;

noise = ifft2(ifftshift(spectr_n));

im_n = real(im_n);
noise = real(noise);

PSF = fspecial('gaussian',3,1);

im_n = edgetaper(im_n,PSF);
noise = edgetaper(noise,PSF);

im_2 = Opt_filtr(im_n,noise,16);


figure
imshow(uint8(im))
title('Исходное изображение')

figure
imshow(uint8(im_n))
title('Изображение с наложенной гарм. помехой')

figure
imshow(uint8(noise))
title('Полученное изображение помехи')

figure
imshow(uint8(im_2))
title('Результат оптимальной узкополосной фильтрации')

SNR_2 = snr(im,im_2 - im);
MSE_2 = sum(sum((im - im_2).^2)) / (size(im,1) * size(im,2));
PSNR_2 = 20*log(255/sqrt(MSE_2))/log(10);
SSIM_2 = ssim(uint8(im),uint8(im_2));
disp('SNR (' + string(SNR_1) + '/' + string(SNR_2) + ')')
disp('PSNR (' + string(PSNR_1) + '/' + string(PSNR_2) + ')')
disp('SSIM (' + string(SSIM_1) + '/' + string(SSIM_2) + ')')

%imwrite(uint8(im_2), 'task5_im_opt.png', 'png')

% Фильтр Винера

im_2 = Filtr_Winn_garm(im_n,R);

figure
imshow(uint8(im_2))
title('Отфильтрованное изображение')


SNR_2 = snr(im,im_2 - im);
MSE_2 = sum(sum((im - im_2).^2)) / (size(im,1) * size(im,2));
PSNR_2 = 20*log(255/sqrt(MSE_2))/log(10);
SSIM_2 = ssim(uint8(im),uint8(im_2));
disp('SNR (' + string(SNR_1) + '/' + string(SNR_2) + ')')
disp('PSNR (' + string(PSNR_1) + '/' + string(PSNR_2) + ')')
disp('SSIM (' + string(SSIM_1) + '/' + string(SSIM_2) + ')')

%imwrite(uint8(im_n), 'task5_im_noise.png', 'png')
%imwrite(uint8(im_2), 'task5_im_w.png', 'png')
%% task 6
clc
close all

im_n1 = imread('task1_im_gauss_noise.png');
im_n2 = imread('task1_im_salt&pepper_noise.png');
im_n1 = double(im_n1);
im_n2 = double(im_n2);

SNR_gauss_1 = snr(im,im_n1 - im);
SNR_sp_1 = snr(im,im_n2 - im);
SSIM_gauss_1 = ssim(uint8(im),uint8(im_n1));
SSIM_sp_1 = ssim(uint8(im),uint8(im_n2));

M = 255;
L = 256;

%im_res1 = My_filt2(im_n1,M, L);
im_res1 = My_filt2(My_filt2(im_n1,M, L),M,L);

%im_res2 = My_filt2(im_n2,M, L);
im_res2 = My_filt2(My_filt2(im_n2,M, L),M,L);
%

figure
imshow(uint8(im_n1))

figure
imshow(uint8(im_n2))

figure
imshow(uint8(im_res1))

figure
imshow(uint8(im_res2))

SNR_gauss_2 = snr(im,im_res1 - im);
SNR_sp_2 = snr(im,im_res2 - im);
SSIM_gauss_2 = ssim(uint8(im),uint8(im_res1));
SSIM_sp_2 = ssim(uint8(im),uint8(im_res2));


disp('SNR_gauss_noise (' + string(SNR_gauss_1) + '/' + string(SNR_gauss_2) + ')')
disp('SNR_sp_noise (' + string(SNR_sp_1) + '/' + string(SNR_sp_2) + ')')
disp('SSIM_gauss_noise (' + string(SSIM_gauss_1) + '/' + string(SSIM_gauss_2) + ')')
disp('SSIM_sp_noise (' + string(SSIM_sp_1) + '/' + string(SSIM_sp_2) + ')')

% imwrite(uint8(im_res1), 'task6_im_gauss2x2.png', 'png')
% imwrite(uint8(im_res2), 'task6_im_sp2x2.png', 'png')