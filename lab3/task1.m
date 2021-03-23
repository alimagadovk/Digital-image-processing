clc
clear
close all

a = imread('quantized_with_noise.bmp');

figure
imshow(a)

% A = double(a(:));
% A = sort(A);
% 
% plot(A)


file = fopen('quantized_with_noise.bin', 'w');
fwrite(file, a);
fclose(file);
%%
close all
file = fopen('quantized_with_noise.bin', 'r');
B = fread(file,[512 512]);
fclose(file);
B = uint8(B);
figure
imshow(B)
%%
close all
file = fopen('decoded_quantized_with_noise_256hist_minmax.bin', 'r');
B = fread(file,[512 512]);
fclose(file);
B = uint8(B);
figure
imshow(B)
A = imread('quantized_without_noise.bmp');
figure
imshow(A)
C = A - B;
figure
imshow(C)
sum(C(:))