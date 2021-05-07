%% task 1
clc
clear
close all

im = imread('1.gif');

im_n1 = imnoise(im,'gaussian',0,0.01);
im_n2 = imnoise(im,'salt & pepper', 0.025);

im = double(im);
im_n1 = double(im_n1);
im_n2 = double(im_n2);

SNR_gauss_1 = snr(im,im_n1 - im);
SNR_sp_1 = snr(im,im_n2 - im);
SSIM_gauss_1 = ssim(uint8(im),uint8(im_n1));
SSIM_sp_1 = ssim(uint8(im),uint8(im_n2));


figure
imshow(uint8(im))

figure
imshow(uint8(im_n1))

figure
imshow(uint8(im_n2))

%imwrite(uint8(im), 'task1_im.png', 'png')
%imwrite(uint8(im_n1), 'task1_im_gauss_noise.png', 'png')
%imwrite(uint8(im_n2), 'task1_im_salt&pepper_noise.png', 'png')
%% task 2
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

N = 3;

im_n1_res1 = spfilt(im_n1, 'amean', N, N);
im_n1_res2 = spfilt(im_n1, 'median', N, N);
im_n1_res3 = spfilt(im_n1, 'atrimmed', N, N, 4);

im_n2_res1 = spfilt(im_n2, 'amean', N, N);
im_n2_res2 = spfilt(im_n2, 'median', N, N);
im_n2_res3 = spfilt(im_n2, 'atrimmed', N, N, 4);

figure
imshow(uint8(im_n1_res1))

figure
imshow(uint8(im_n1_res2))

figure
imshow(uint8(im_n1_res3))

figure
imshow(uint8(im_n2_res1))

figure
imshow(uint8(im_n2_res2))

figure
imshow(uint8(im_n2_res3))

SNR_gauss_amean = snr(im,im_n1_res1 - im);
SNR_gauss_median = snr(im,im_n1_res2 - im);
SNR_gauss_atrimmed = snr(im,im_n1_res3 - im);

SNR_saltpepper_amean = snr(im,im_n2_res1 - im);
SNR_saltpepper_median = snr(im,im_n2_res2 - im);
SNR_saltpepper_atrimmed = snr(im,im_n2_res3 - im);

SSIM_gauss_amean = ssim(uint8(im),uint8(im_n1_res1));
SSIM_gauss_median = ssim(uint8(im),uint8(im_n1_res2));
SSIM_gauss_atrimmed = ssim(uint8(im),uint8(im_n1_res3));

SSIM_saltpepper_amean = ssim(uint8(im),uint8(im_n2_res1));
SSIM_saltpepper_median = ssim(uint8(im),uint8(im_n2_res2));
SSIM_saltpepper_atrimmed = ssim(uint8(im),uint8(im_n2_res3));


disp('SNR_gauss_amean (' + string(SNR_gauss_1) + '/' + string(SNR_gauss_amean) + ')')
disp('SNR_gauss_median (' + string(SNR_gauss_1) + '/' + string(SNR_gauss_median) + ')')
disp('SNR_gauss_atrimmed (' + string(SNR_gauss_1) + '/' + string(SNR_gauss_atrimmed) + ')')
disp('SNR_sp_amean (' + string(SNR_sp_1) + '/' + string(SNR_saltpepper_amean) + ')')
disp('SNR_sp_median (' + string(SNR_sp_1) + '/' + string(SNR_saltpepper_median) + ')')
disp('SNR_sp_atrimmed (' + string(SNR_sp_1) + '/' + string(SNR_saltpepper_atrimmed) + ')')

disp('SSIM_gauss_amean (' + string(SSIM_gauss_1) + '/' + string(SSIM_gauss_amean) + ')')
disp('SSIM_gauss_median (' + string(SSIM_gauss_1) + '/' + string(SSIM_gauss_median) + ')')
disp('SSIM_gauss_atrimmed (' + string(SSIM_gauss_1) + '/' + string(SSIM_gauss_atrimmed) + ')')
disp('SSIM_sp_amean (' + string(SSIM_sp_1) + '/' + string(SSIM_saltpepper_amean) + ')')
disp('SSIM_sp_median (' + string(SSIM_sp_1) + '/' + string(SSIM_saltpepper_median) + ')')
disp('SSIM_sp_atrimmed (' + string(SSIM_sp_1) + '/' + string(SSIM_saltpepper_atrimmed) + ')')

%imwrite(uint8(im_n1_res1), 'task2_gauss_amean.png', 'png')
%imwrite(uint8(im_n1_res2), 'task2_gauss_median.png', 'png')
%imwrite(uint8(im_n1_res3), 'task2_gauss_atrimmed.png', 'png')
%imwrite(uint8(im_n2_res1), 'task2_salt&pepper_amean.png', 'png')
%imwrite(uint8(im_n2_res2), 'task2_salt&pepper_median.png', 'png')
%imwrite(uint8(im_n2_res3), 'task2_salt&pepper_atrimmed.png', 'png')
%% task 3
clc
close all

[M, N] = size(im);

S1 = fftshift(fft2(im_n1));
S2 = fftshift(fft2(im_n2));

D0_1 = 143;
H1 = Gauss_peak(M,N,D0_1);

D0_2 = 146;
H2 = Gauss_peak(M,N,D0_2);

J1 = abs(ifft2(ifftshift(H1.*S1)));
J2 = abs(ifft2(ifftshift(H2.*S2)));

figure
imshow(uint8(J1))

figure
imshow(uint8(J2))

SNR_gauss_2 = snr(im,J1 - im);
SNR_sp_2 = snr(im,J2 - im);
SSIM_gauss_2 = ssim(uint8(im),uint8(J1));
SSIM_sp_2 = ssim(uint8(im),uint8(J2));

disp('SNR_gauss_noise (' + string(SNR_gauss_1) + '/' + string(SNR_gauss_2) + ')')
disp('SNR_sp_noise (' + string(SNR_sp_1) + '/' + string(SNR_sp_2) + ')')
disp('SSIM_gauss_noise (' + string(SSIM_gauss_1) + '/' + string(SSIM_gauss_2) + ')')
disp('SSIM_sp_noise (' + string(SSIM_sp_1) + '/' + string(SSIM_sp_2) + ')')

%imwrite(uint8(J1), 'task3_gauss.png', 'png')
%imwrite(uint8(J2), 'task3_salt&pepper.png', 'png')
%% task 4
clc
close all

lamb_g_h = 66;

lamb_sp_h = 0;

lamb_g_s = 27;

lamb_sp_s = 29;



levels = 3;

J_g_h = Hard_Filt_w(im_n1,levels,lamb_g_h);
J_sp_h = Hard_Filt_w(im_n2,levels,lamb_sp_h);
J_g_s = Soft_Filt_w(im_n1,levels,lamb_g_s);
J_sp_s = Soft_Filt_w(im_n2,levels,lamb_sp_s);

figure
imshow(uint8(J_g_h))
title('gauss noise hard filt')

figure
imshow(uint8(J_sp_h))
title('sp noise hard filt')

figure
imshow(uint8(J_g_s))
title('gauss noise soft filt')

figure
imshow(uint8(J_sp_s))
title('sp noise soft filt')

SNR_gauss_h_2 = snr(im,J_g_h - im);
SNR_sp_h_2 = snr(im,J_sp_h - im);
SSIM_gauss_h_2 = ssim(uint8(im),uint8(J_g_h));
SSIM_sp_h_2 = ssim(uint8(im),uint8(J_sp_h));

SNR_gauss_s_2 = snr(im,J_g_s - im);
SNR_sp_s_2 = snr(im,J_sp_s - im);
SSIM_gauss_s_2 = ssim(uint8(im),uint8(J_g_s));
SSIM_sp_s_2 = ssim(uint8(im),uint8(J_sp_s));

disp('SNR_gauss_noise_h_filt (' + string(SNR_gauss_1) + '/' + string(SNR_gauss_h_2) + ')')
disp('SNR_sp_noise_h_filt (' + string(SNR_sp_1) + '/' + string(SNR_sp_h_2) + ')')
disp('SNR_gauss_noise_s_filt (' + string(SNR_gauss_1) + '/' + string(SNR_gauss_s_2) + ')')
disp('SNR_sp_noise_s_filt (' + string(SNR_sp_1) + '/' + string(SNR_sp_s_2) + ')')

disp('SSIM_gauss_noise_h_filt (' + string(SSIM_gauss_1) + '/' + string(SSIM_gauss_h_2) + ')')
disp('SSIM_sp_noise_h_filt (' + string(SSIM_sp_1) + '/' + string(SSIM_sp_h_2) + ')')
disp('SSIM_gauss_noise_s_filt (' + string(SSIM_gauss_1) + '/' + string(SSIM_gauss_s_2) + ')')
disp('SSIM_sp_noise_s_filt (' + string(SSIM_sp_1) + '/' + string(SSIM_sp_s_2) + ')')

% imwrite(uint8(J_g_h), 'task4_gauss_h.png', 'png')
% imwrite(uint8(J_sp_h), 'task4_salt&pepper_h.png', 'png')
% imwrite(uint8(J_g_s), 'task4_gauss_s.png', 'png')
% imwrite(uint8(J_sp_s), 'task4_salt&pepper_s.png', 'png')
%% task 5
close all
K = 85;
%K = 50;

dark = @(x) max(min(1, -(x - 127)/K), 0);
bright = @(x) max(min(1, (x - 127)/K), 0);
gray = @(x) -dark(x) - bright(x) + 1;
v = @(z) 127*gray(z) + 255*bright(z);
res = v(im);
figure
imshow(uint8(im))
figure
imshow(uint8(res))

figure
hold on
grid on
plot(0:255,dark(0:255))
plot(0:255,bright(0:255))
plot(0:255,gray(0:255))

figure
imshow(uint8(v(im_n1)))

figure
imshow(uint8(v(im_n2)))


%
I = imread('pout.tif');
J = v(double(I));

figure
imshow(I)

figure
imshow(uint8(J))

% imwrite(uint8(res), 'task5_im_contrast.png', 'png')
% imwrite(uint8(v(im_n1)), 'task5_im_n1_contrast.png', 'png')
% imwrite(uint8(v(im_n2)), 'task5_im_n2_contrast.png', 'png')
%imwrite(uint8(J), 'task5_pout_contrast.png', 'png')