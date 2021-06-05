%% task 1
clc
clear
close all

im = imread('task1_im.png');
im = double(im);

[M, N] = size(im);

PSF = fspecial("motion", 10, 45);

[m,n] = size(PSF);

im_n = imread('task1_im_n.png');
im_n = double(im_n);

% im2 = imfilter(im, PSF, 'replicate');
% 
% im_n = imnoise(uint8(im2),'gaussian',0,0.001);
% im_n = double(im_n);

%imwrite(uint8(im_n), 'task1_im_n.png', 'png')

SNR = snr(im,im_n - im);
SSIM = ssim(uint8(im),uint8(im_n));

figure
imshow(uint8(im_n))

% а)

epsilon = 0.2;
H = zeros(M,N);
H(1:m,1:n) = PSF;
H = fftshift(fft2(H));
Inv_H = 1./H;
Inv_H(abs(H) < epsilon) = 0;
% figure
% mesh(abs(Inv_H))

sg = fftshift(fft2(im_n));
im_res = ifft2(ifftshift(sg.*Inv_H));

SNR_Inv = snr(im,im_res - im);
SSIM_Inv = ssim(uint8(im),uint8(im_res));

disp('SNR_Inv (' + string(SNR) + '/' + string(SNR_Inv) + ')')
disp('SSIM_Inv (' + string(SSIM) + '/' + string(SSIM_Inv) + ')')

figure
imshow(uint8(im_res))
title('Инверсная фильтрация')

%imwrite(uint8(im_res), 'task1_inv_filt.png', 'png')
% б)

% поиск оптимального значения параметра NSR
% NSR = 0.001:0.001:0.1;
% for i = 1:length(NSR)
%     im_res = deconvwnr(im_n,PSF,NSR(i));
%     SNR_W(i) = snr(im,im_res - im);
%     SSIM_W(i) = ssim(uint8(im),uint8(im_res));
% end
% 
% max_SNR = max(SNR_W);
% NSR_m = NSR(SNR_W == max_SNR);
% 
% figure
% hold on
% grid on
% plot(NSR, SNR_W)
% plot(NSR_m,max_SNR,'*r')
% xlabel('NSR')
% ylabel('SNR')
% title('SNR(NSR)')
% 
% figure
% hold on
% grid on
% plot(NSR, SSIM_W)
% xlabel('NSR')
% ylabel('SSIM')
% title('SSIM(NSR)')

NSR = 0.068;
im_res = deconvwnr(im_n,PSF,NSR);

SNR_W = snr(im,im_res - im);
SSIM_W = ssim(uint8(im),uint8(im_res));

disp('SNR_W (' + string(SNR) + '/' + string(SNR_W) + ')')
disp('SSIM_W (' + string(SSIM) + '/' + string(SSIM_W) + ')')

figure
imshow(uint8(im_res))
title('Винеровская фильтрация (NSR)')

%imwrite(uint8(im_res), 'task1_Win_filt_NSR.png', 'png')
% в)
epsilon1 = 0.01;
epsilon2 = 0.3;

Sg = abs(sg).^2;
Sn = M*N*0.001;

Sf = (Sg - Sn);
Sf(abs(Sf)./(M*N) < epsilon1) = 0;
Inv_H = 1./(H.*conj(H));
Inv_H(abs(H) < epsilon2) = 0;
Sf = Sf.*Inv_H;
NCORR = ifft2(ifftshift(Sn));
ICORR = ifft2(ifftshift(Sf));
    
im_res = double(deconvwnr(uint8(im_n),PSF,NCORR,ICORR));
    
SNR_W2 = snr(im,im_res - im);
SSIM_W2 = ssim(uint8(im),uint8(im_res));


disp('SNR_W2 (' + string(SNR) + '/' + string(SNR_W2) + ')')
disp('SSIM_W2 (' + string(SSIM) + '/' + string(SSIM_W2) + ')')

figure
imshow(uint8(im_res))
title('Винеровская фильтрация (NCORR/ICORR)')

%imwrite(uint8(im_res), 'task1_Win_filt_NCORR_ICORR.png', 'png')
% г)
RANGE = [1e-10 1e10];
im_res = double(deconvreg(uint8(im_n), PSF, Sn, RANGE));

SNR_TR = snr(im,im_res - im);
SSIM_TR = ssim(uint8(im),uint8(im_res));


disp('SNR_TR (' + string(SNR) + '/' + string(SNR_TR) + ')')
disp('SSIM_TR (' + string(SSIM) + '/' + string(SSIM_TR) + ')')

figure
imshow(uint8(im_res))
title('Фильтрация на основе регуляризации по Тихонову')

%imwrite(uint8(im_res), 'task1_Tikhonov_filt.png', 'png')
%% task 2
clc
clear
close all

im = imread('task1_im.png');
im = double(im);

[M, N] = size(im);

PSF = fspecial("motion", 10, 45);

[m,n] = size(PSF);

im_n = imread('task1_im_n.png');
im_n = double(im_n);

SNR = snr(im,im_n - im);
SSIM = ssim(uint8(im),uint8(im_n));

psf = fspecial('gaussian',5,2.5);

im_n = edgetaper(im_n,psf);

figure
imshow(uint8(im_n))

% а)

epsilon = 0.2;
H = zeros(M,N);
H(1:m,1:n) = PSF;
H = fftshift(fft2(H));
Inv_H = 1./H;
Inv_H(abs(H) < epsilon) = 0;


sg = fftshift(fft2(im_n));
im_res = ifft2(ifftshift(sg.*Inv_H));

SNR_Inv = snr(im,im_res - im);
SSIM_Inv = ssim(uint8(im),uint8(im_res));

disp('SNR_Inv (' + string(SNR) + '/' + string(SNR_Inv) + ')')
disp('SSIM_Inv (' + string(SSIM) + '/' + string(SSIM_Inv) + ')')

figure
imshow(uint8(im_res))
title('Инверсная фильтрация')

%imwrite(uint8(im_res), 'task2_inv_filt_edgetap.png', 'png')
% б)

NSR = 0.068;
im_res = deconvwnr(im_n,PSF,NSR);

SNR_W = snr(im,im_res - im);
SSIM_W = ssim(uint8(im),uint8(im_res));

disp('SNR_W (' + string(SNR) + '/' + string(SNR_W) + ')')
disp('SSIM_W (' + string(SSIM) + '/' + string(SSIM_W) + ')')

figure
imshow(uint8(im_res))
title('Винеровская фильтрация (NSR)')

%imwrite(uint8(im_res), 'task2_Win_filt_NSR_edgetap.png', 'png')

% в)
epsilon1 = 0.01;
epsilon2 = 0.3;

Sg = abs(sg).^2;
Sn = M*N*0.001;

Sf = (Sg - Sn);
Sf(abs(Sf)./(M*N) < epsilon1) = 0;
Inv_H = 1./(H.*conj(H));
Inv_H(abs(H) < epsilon2) = 0;
Sf = Sf.*Inv_H;
NCORR = ifft2(ifftshift(Sn));
ICORR = ifft2(ifftshift(Sf));
    
im_res = double(deconvwnr(uint8(im_n),PSF,NCORR,ICORR));
    
SNR_W2 = snr(im,im_res - im);
SSIM_W2 = ssim(uint8(im),uint8(im_res));


disp('SNR_W2 (' + string(SNR) + '/' + string(SNR_W2) + ')')
disp('SSIM_W2 (' + string(SSIM) + '/' + string(SSIM_W2) + ')')

figure
imshow(uint8(im_res))
title('Винеровская фильтрация (NCORR/ICORR)')

%imwrite(uint8(im_res), 'task2_Win_filt_NCORR_ICORR_edgetap.png', 'png')
% г)
RANGE = [1e-10 1e10];
im_res = double(deconvreg(uint8(im_n), PSF, Sn, RANGE));

SNR_TR = snr(im,im_res - im);
SSIM_TR = ssim(uint8(im),uint8(im_res));


disp('SNR_TR (' + string(SNR) + '/' + string(SNR_TR) + ')')
disp('SSIM_TR (' + string(SSIM) + '/' + string(SSIM_TR) + ')')

figure
imshow(uint8(im_res))
title('Фильтрация на основе регуляризации по Тихонову')

%imwrite(uint8(im_res), 'task2_Tikhonov_filt_edgetap.png', 'png');
%% tasks 3-4
clc
clear
close all

I = imread('task1_im.png');
H = fspecial("motion", 10, 45); %смаз брать тот же, что и в п.1
J = imfilter(I,H,'replicate');
I = double(I);
J = double(J);
SNR = snr(I,J - I);
SSIM = ssim(uint8(I),uint8(J));
PSF = fspecial('gaussian',60,10);
J = edgetaper(J,PSF);

% поиск оптимального значения NIT
% for i = 1:50
% 
% G = deconvlucy(J,H,i);
% 
% SNR_LR(i) = snr(I,G - I);
% SSIM_LR(i) = ssim(uint8(I),uint8(G));
% end
% 
% figure
% hold on
% grid on
% plot(SSIM_LR)
% xlabel('NIT')
% ylabel('SSIM(NIT)')
% title('SSIM')
% 
% M_SSIM = max(SSIM_LR);
% M_NIT = find(SSIM_LR == M_SSIM);
% plot(M_NIT,M_SSIM,'r*')

G = deconvlucy(J,H,38);
% without edgetaper N = 25
% with edgetaper N = 38


SNR_LR = snr(I,G - I);
SSIM_LR = ssim(uint8(I),uint8(G));

disp('SNR_LR (' + string(SNR) + '/' + string(SNR_LR) + ')')
disp('SSIM_LR (' + string(SSIM) + '/' + string(SSIM_LR) + ')')

figure
imshow(uint8(I))
figure
imshow(uint8(J))
figure
imshow(uint8(G))

%imwrite(uint8(J), 'task3_motion.png', 'png');
%imwrite(uint8(G), 'task3_LR_filt_edgetap.png', 'png');
%imwrite(uint8(J), 'task4_motion.png', 'png');
%imwrite(uint8(G), 'task4_LR_filt.png', 'png');
%% tasks 5
clc
clear
close all

I = imread('task1_im.png');
H = fspecial("motion", 10, 45);
J = imread('task1_im_n.png');



I = double(I);
J = double(J);

SNR = snr(I,J - I);
SSIM = ssim(uint8(I),uint8(J));

PSF = fspecial('gaussian',60,10);
J = edgetaper(J,PSF);

% поиск оптимальных значений параметров
% v_n = 1:10;
% v_d = 0:0.1:1.5;
% 
% for i = 1:length(v_n)
%     i
%     for j = 1:length(v_d)
%         G = double(deconvlucy(double(J),H,v_n(i),v_d(j)));
%         
%         SNR_LR(i,j) = snr(I,G - I);
%         SSIM_LR(i,j) = ssim(uint8(I),uint8(G));
%     end
% end
% 
% [X, Y] = meshgrid(v_n,v_d);
% 
% M_SNR = max(SNR_LR(:));
% M_SSIM = max(SSIM_LR(:));
% 
% figure
% hold on
% grid on
% mesh(X,Y,SNR_LR')
% plot3(X(SNR_LR' == M_SNR),Y(SNR_LR' == M_SNR),SNR_LR(SNR_LR == M_SNR), '*r')
% xlabel('NIT')
% ylabel('DAMPAR')
% title('SNR')
% 
% figure
% hold on
% grid on
% mesh(X,Y,SSIM_LR')
% plot3(X(SSIM_LR' == M_SSIM),Y(SSIM_LR' == M_SSIM),SSIM_LR(SSIM_LR == M_SSIM), '*r')
% xlabel('NIT')
% ylabel('DAMPAR')
% title('SSIM')

G = deconvlucy(J,H,4,0);

SNR_LR = snr(I,G - I);
SSIM_LR = ssim(uint8(I),uint8(G));

disp('SNR_LR (' + string(SNR) + '/' + string(SNR_LR) + ')')
disp('SSIM_LR (' + string(SSIM) + '/' + string(SSIM_LR) + ')')

figure
imshow(uint8(I))
figure
imshow(uint8(J))
figure
imshow(uint8(G))

%imwrite(uint8(J), 'task5_motion_noise.png', 'png');
%imwrite(uint8(G), 'task5_LR_filt_SNR.png', 'png');
%%
clc
clear
close all

I = imread('task1_im.png');
H = fspecial("motion", 10, 45); %смаз брать тот же, что и в п.1
R = zeros(512,512);
R(1:size(H,1),1:size(H,2)) = H;
R = fftshift(fft2(R));
figure
mesh(abs(R))
J = imfilter(I,H,'replicate');
%J = imread('task1_im_n.png');
J = double(J);

sc = fftshift(ifft2(-log(abs(fft2(J)) + 0.001)));
figure
hold on
grid on
mesh(sc)
camlight
axis([220 290 220 290 0 0.3])
view(25,20)