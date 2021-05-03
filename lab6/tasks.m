% task 1
clc
clear
close all

mask1 = fspecial('laplacian',0);

mask2 = fspecial('laplacian',0.5);

mask3 = fspecial('laplacian',1);

N = 30;

M1 = zeros(N);
M2 = M1;
M3 = M1;

M1(1:3,1:3) = mask1;
M2(1:3,1:3) = mask2;
M3(1:3,1:3) = mask3;

S1 = fftshift(fft2(M1));
S2 = fftshift(fft2(M2));
S3 = fftshift(fft2(M3));

figure
mesh(abs(S1))
hold on
grid on
title('АЧХ Лапласиана при alpha = 0')

figure
mesh(abs(S2))
hold on
grid on
title('АЧХ Лапласиана при alpha = 0.5')


figure
mesh(abs(S3))
hold on
grid on
title('АЧХ Лапласиана при alpha = 1')
%% task 2
clc
clear
close all

I = imread('1.gif');
[M, N] = size(I);

S = fftshift(fft2(I));

D0 = 30;
H1 = Gauss_peak(M,N,D0);
H2 = Perf_filt(M,N,D0);

J1 = abs(ifft2(ifftshift(H1.*S)));
J2 = abs(ifft2(ifftshift(H2.*S)));

figure
mesh(H1)

figure
mesh(H2)

figure
imshow(uint8(J1))

figure
imshow(uint8(J2))

%imwrite(uint8(J1), 'task2_gauss.png', 'png')
%imwrite(uint8(J2), 'task2_perf_filt.png', 'png')
%% task 3
clc
clear
close all

I = imread('1.gif');
[M, N] = size(I);

S = fftshift(fft2(I));

D0 = 30;
H1 = 1 - Gauss_peak(M,N,D0);
H2 = 1 - Perf_filt(M,N,D0);

J1 = abs(ifft2(ifftshift(H1.*S)));
J2 = abs(ifft2(ifftshift(H2.*S)));

figure
imshow(I)

figure
mesh(H1)

figure
mesh(H2)

figure
imshow(I + uint8(J1))

figure
imshow(I + uint8(J2))

%imwrite(I + uint8(J1), 'task3_gauss.png', 'png')
%imwrite(I + uint8(J2), 'task3_perf_filt.png', 'png')
%% task 4
clc
clear
close all

I = imread('pout.tif');

mask = [0, 0, 0;
        0, 1, 0;
        0, 0, 0] - fspecial('laplacian',0);
J1 = imfilter(imadjust(I), mask, 'symmetric');
J2 = imadjust(imfilter(I, mask, 'symmetric'));

figure
imshow(I)

figure
imshow(J1)

figure
imshow(J2)

%imwrite(J1, 'task4_eq_lapl.png', 'png')
%imwrite(J2, 'task4_lapl_eq.png', 'png')
%% task 5
clc
clear
close all
im = imread('1.gif');

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
h = 1 - Gauss_filt(M,N,D0,u0,v0);

PSF = fspecial('gaussian',3,1);

im_n = edgetaper(im_n,PSF);
spectr = fftshift(fft2(im_n));

im_2 = abs(ifft2(ifftshift(h.*spectr)));

figure
mesh(h)
title('АЧХ фильтра Гаусса')

figure
imshow(uint8(im))
title('Исходное изображение')

figure
imshow(uint8(im_n))
title('Изображение с наложенной гарм. помехой')

figure
imshow(uint8(im_2))



SNR_2 = snr(im,im_2 - im);
MSE_2 = sum(sum((im - im_2).^2)) / (size(im,1) * size(im,2));
PSNR_2 = 20*log(255/sqrt(MSE_2))/log(10);
SSIM_2 = ssim(uint8(im),uint8(im_2));
disp('SNR (' + string(SNR_1) + '/' + string(SNR_2) + ')')
disp('PSNR (' + string(PSNR_1) + '/' + string(PSNR_2) + ')')
disp('SSIM (' + string(SSIM_1) + '/' + string(SSIM_2) + ')')

%imwrite(uint8(im_n), 'task5_im_n.png', 'png')
%imwrite(uint8(im_2), 'task5_im_2.png', 'png')
%% task 6
clc
clear
close all
I = imread('1.gif');

W = [-1, 2, -1;
     -2, 5, -2;
     -1, 2, -1];
 
 J1 = imfilter(I, W, 'symmetric');
 J2 = imfilter(I, W', 'symmetric');

figure
imshow(I)
 
figure
imshow(uint8(J1))

figure
imshow(uint8(J2))

%
N = 512;

M1 = zeros(N);
M2 = M1;

M1(1:3,1:3) = W;
M2(1:3,1:3) = W';

S1 = fftshift(fft2(M1));
S2 = fftshift(fft2(M2));

figure
mesh(abs(S1))
hold on
grid on
title('АЧХ фильтра с маской W')

figure
mesh(abs(S2))
hold on
grid on
title("АЧХ фильтра с маской W'")

%imwrite(uint8(J1), 'task6_W.png', 'png')
%imwrite(uint8(J2), 'task6_WT.png', 'png')