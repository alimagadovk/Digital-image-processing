% task 1
close all
I = imread('flowers_bw.png');
B = strel('square',3);
G1 = imopen(I,B);
G2 = imclose(I,B);
G3 = imdilate(I,B);
G4 = imerode(I,B);

figure
imshow(I)

figure
imshow(G1)

figure
imshow(G2)

figure
imshow(G3)

figure
imshow(G4)

% imwrite(uint8(G1), 'task1_imopen_square.png', 'png')
% imwrite(uint8(G2), 'task1_imclose_square.png', 'png')
% imwrite(uint8(G3), 'task1_imdilate_square.png', 'png')
% imwrite(uint8(G4), 'task1_imerode_square.png', 'png')
%%
close all
B = strel('disk',5);
G1 = imopen(I,B);
G2 = imclose(I,B);
G3 = imdilate(I,B);
G4 = imerode(I,B);

figure
imshow(I)

figure
imshow(G1)

figure
imshow(G2)

figure
imshow(G3)

figure
imshow(G4)

% imwrite(uint8(G1), 'task1_imopen_disk.png', 'png')
% imwrite(uint8(G2), 'task1_imclose_disk.png', 'png')
% imwrite(uint8(G3), 'task1_imdilate_disk.png', 'png')
% imwrite(uint8(G4), 'task1_imerode_disk.png', 'png')
%%
close all
BW3 = bwmorph(I,'skel',Inf);
figure
imshow(BW3)

% imwrite(uint8(BW3)*255, 'task1_ostov.png', 'png')
%%
close all
B = strel('disk',1);
G = imdilate(I,B)-imerode(I,B);
figure
imshow(G)

% imwrite(uint8(G), 'task1_contours.png', 'png')
%%

[M, N] = size(I);

p = {[-1 -1 -1; 0 1 0; 1 1 1],
    [0 -1 -1; 1 1 -1; 1 1 0],
    [1 0 -1; 1 1 -1; 1 0 -1],
    [1 1 0; 1 1 -1; 0 -1 -1],
    [1 1 1; 0 1 0; -1 -1 -1],
    [0 1 1; -1 1 1; -1 -1 0],
    [-1 0 1; -1 1 1; -1 0 1],
    [-1 -1 0; -1 1 1; 0 1 1]};

im_curr = I;
im_prev = zeros(M,N);
while ~prod(im_curr(:) == im_prev(:))
    im_prev = im_curr;
    for i=1:8
        im_curr = im_curr & ~bwhitmiss(im_curr, p{i});
    end
end
figure
imshow(im_curr)

BW3 = bwmorph(I,'thin',Inf);
figure
imshow(BW3)

% imwrite(uint8(im_curr)*255, 'task1_my_thin.png', 'png')
% imwrite(uint8(BW3)*255, 'task1_thin.png', 'png')
%% task 2
clc
clear
close all

I = imread('task1_im.png');
im = double(I);

B = strel('diamond',5);
G1 = imopen(I,B);
G2 = imclose(I,B);
G3 = imdilate(I,B);
G4 = imerode(I,B);

figure
imshow(I)

figure
imshow(G1)

figure
imshow(G2)

figure
imshow(G3)

figure
imshow(G4)

% imwrite(uint8(G1), 'task2_imopen_diamond.png', 'png')
% imwrite(uint8(G2), 'task2_imclose_diamond.png', 'png')
% imwrite(uint8(G3), 'task2_imdilate_diamond.png', 'png')
% imwrite(uint8(G4), 'task2_imerode_diamond.png', 'png')
%%

B = strel('sphere',4);
G1 = imopen(I,B);
G2 = imclose(I,B);
G3 = imdilate(I,B);
G4 = imerode(I,B);

figure
imshow(I)

figure
imshow(G1)

figure
imshow(G2)

figure
imshow(G3)

figure
imshow(G4)

% imwrite(uint8(G1), 'task2_imopen_sphere.png', 'png')
% imwrite(uint8(G2), 'task2_imclose_sphere.png', 'png')
% imwrite(uint8(G3), 'task2_imdilate_sphere.png', 'png')
% imwrite(uint8(G4), 'task2_imerode_sphere.png', 'png')
%% 
close all
B = strel('diamond',5);
G1 = imclose(imopen(I,B),B);
G2 = imdilate(I,B) - imerode(I,B);
G3 = imtophat(I,B);
G4 = imbothat(I,B);

figure
imshow(I)

figure
imshow(G1)

figure
imshow(G2)

figure
imshow(G3)

figure
imshow(G4)

% imwrite(uint8(G1), 'task2_smoothing_diamond.png', 'png')
% imwrite(uint8(G2), 'task2_gradient_diamond.png', 'png')
% imwrite(uint8(G3), 'task2_tophat_diamond.png', 'png')
% imwrite(uint8(G4), 'task2_bothat_diamond.png', 'png')
%%
close all
B = strel('sphere',4);
G1 = imclose(imopen(I,B),B);
G2 = imdilate(I,B) - imerode(I,B);
G3 = imtophat(I,B);
G4 = imbothat(I,B);

figure
imshow(I)

figure
imshow(G1)

figure
imshow(G2)

figure
imshow(G3)

figure
imshow(G4)

% imwrite(uint8(G1), 'task2_smoothing_sphere.png', 'png')
% imwrite(uint8(G2), 'task2_gradient_sphere.png', 'png')
% imwrite(uint8(G3), 'task2_tophat_sphere.png', 'png')
% imwrite(uint8(G4), 'task2_bothat_sphere.png', 'png')
%%
close all
B = strel('sphere',2);
G = I - imbothat(I,B) + imtophat(I,B);

figure
imshow(I)

figure
imshow(G)

% imwrite(uint8(G), 'task2_contours.png', 'png')
%% task 3
clc
clear
close all

I = imread('task1_im.png');
I1 = imread('task1_im_gauss_noise.png');
I2 = imread('task1_im_salt&pepper_noise.png');
%I1 = double(I1);
%I2 = double(I2);

SNR_gauss_1 = snr(double(I),double(I1) - double(I));
SNR_sp_1 = snr(double(I),double(I2) - double(I));
SSIM_gauss_1 = ssim(I,I1);
SSIM_sp_1 = ssim(I,I2);

figure
imshow(I1)

figure
imshow(I2)


B = strel('diamond', 1);

G1 = imclose(imopen(I1,B),B);
G2 = imclose(imopen(I2,B),B);

SNR_gauss_2 = snr(double(I),double(G1) - double(I));
SNR_sp_2 = snr(double(I),double(G2) - double(I));
SSIM_gauss_2 = ssim(I,G1);
SSIM_sp_2 = ssim(I,G2);

disp('SNR_gauss_noise (' + string(SNR_gauss_1) + '/' + string(SNR_gauss_2) + ')')
disp('SNR_sp_noise (' + string(SNR_sp_1) + '/' + string(SNR_sp_2) + ')')
disp('SSIM_gauss_noise (' + string(SSIM_gauss_1) + '/' + string(SSIM_gauss_2) + ')')
disp('SSIM_sp_noise (' + string(SSIM_sp_1) + '/' + string(SSIM_sp_2) + ')')


B = strel('square', 3);

G3 = imclose(imopen(I1,B),B);
G4 = imclose(imopen(I2,B),B);

SNR_gauss_2 = snr(double(I),double(G3) - double(I));
SNR_sp_2 = snr(double(I),double(G4) - double(I));
SSIM_gauss_2 = ssim(I,G3);
SSIM_sp_2 = ssim(I,G4);

disp('SNR_gauss_noise (' + string(SNR_gauss_1) + '/' + string(SNR_gauss_2) + ')')
disp('SNR_sp_noise (' + string(SNR_sp_1) + '/' + string(SNR_sp_2) + ')')
disp('SSIM_gauss_noise (' + string(SSIM_gauss_1) + '/' + string(SSIM_gauss_2) + ')')
disp('SSIM_sp_noise (' + string(SSIM_sp_1) + '/' + string(SSIM_sp_2) + ')')

figure
imshow(G1)

figure
imshow(G2)


figure
imshow(G3)

figure
imshow(G4)

% imwrite(uint8(G1), 'task3_gauss_cross.png', 'png')
% imwrite(uint8(G2), 'task3_s&p_cross.png', 'png')
% imwrite(uint8(G3), 'task3_gauss_square.png', 'png')
% imwrite(uint8(G4), 'task3_s&p_square.png', 'png')