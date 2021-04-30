clc
clear
quality1 = [1 5 10 20 30 40 50 60 70 80 90 100];  % Параметр качества выбираем целым из диапазона ~ 1..100
quality2 = [1 2 3 4 5 7 9 10 12 15 17 20];
I = im2double(imread('1.gif'));  %обрабатываемое изображение
for my_ind = 1:length(quality1)
    imwrite(im2uint8(I),char(strcat('task8_quality=', num2str(quality1(my_ind)),'.jpg')),'jpg', 'Quality', quality1(my_ind));
    I2_jp = im2double(imread(char(strcat('task8_quality=', num2str(quality1(my_ind)), '.jpg'))));
    imwrite(im2uint8(I),char(strcat('task8_quality=', num2str(quality2(my_ind)), '.jp2')),'jp2', 'Quality', quality2(my_ind));
    I2_jp2 = im2double(imread(char(strcat('task8_quality=', num2str(quality2(my_ind)), '.jp2'))));
    
    PSNR8_jp(my_ind) = 10*log10(512*512/sum(sum((I-I2_jp).^2)))
    SSIM8_jp(my_ind) = ssim(im2uint8(I),im2uint8(I2_jp))
    s_jp = dir(strcat('task8_quality=', num2str(quality1(my_ind)), '.jpg'));
    the_size_jp = s_jp.bytes;
    bpp8_jp(my_ind) = 8 * the_size_jp / 512^2
    
    
    PSNR8_jp2(my_ind) = 10*log10(512*512/sum(sum((I-I2_jp2).^2)))
    SSIM8_jp2(my_ind) = ssim(im2uint8(I),im2uint8(I2_jp2))
    s_jp2 = dir(strcat('task8_quality=', num2str(quality2(my_ind)), '.jp2'));
    the_size_jp2 = s_jp2.bytes;
    bpp8_jp2(my_ind) = 8 * the_size_jp2 / 512^2
end
%%
% fileID = fopen('bpp8_jp.txt','w');
% fprintf(fileID,'%.16f\n',bpp8_jp);
% fclose(fileID);
% fileID = fopen('PSNR8_jp.txt','w');
% fprintf(fileID,'%.16f\n',PSNR8_jp);
% fclose(fileID);
% fileID = fopen('SSIM8_jp.txt','w');
% fprintf(fileID,'%.16f\n',SSIM8_jp);
% fclose(fileID);

% fileID = fopen('bpp8_jp2.txt','w');
% fprintf(fileID,'%.16f\n',bpp8_jp2);
% fclose(fileID);
% fileID = fopen('PSNR8_jp2.txt','w');
% fprintf(fileID,'%.16f\n',PSNR8_jp2);
% fclose(fileID);
% fileID = fopen('SSIM8_jp2.txt','w');
% fprintf(fileID,'%.16f\n',SSIM8_jp2);
% fclose(fileID);
%%
close all
figure
hold on
grid on
plot(bpp8_jp, PSNR8_jp, '*b', 'LineWidth', 1.5)
p1 = plot(bpp8_jp, PSNR8_jp, 'b', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), task8, jpeg');
plot(bpp8_jp2, PSNR8_jp2, '*r', 'LineWidth', 1.5)
p2 = plot(bpp8_jp2, PSNR8_jp2, 'r', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), task8, jpeg2000');

xlabel('bpp')
ylabel('PSNR')
title('PSNR(bpp)')
legend([p1, p2], 'Location', 'northwest')

figure
hold on
grid on
plot(bpp8_jp, SSIM8_jp, '*b', 'LineWidth', 1.5)
p1 = plot(bpp8_jp, SSIM8_jp, 'b', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), task8, jpeg');
plot(bpp8_jp2, SSIM8_jp2, '*r', 'LineWidth', 1.5)
p2 = plot(bpp8_jp2, SSIM8_jp2, 'r', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), task8, jpeg2000');

xlabel('bpp')
ylabel('SSIM')
title('SSIM(bpp)')
legend([p1, p2], 'Location', 'southeast')