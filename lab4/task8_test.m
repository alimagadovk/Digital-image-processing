clc
clear
close all

fileID = fopen('bpp8_1.txt','r');
bpp8_1 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR8_1.txt','r');
PSNR8_1 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM8_1.txt','r');
SSIM8_1 = fscanf(fileID,'%f\n');
fclose(fileID);

fileID = fopen('bpp8_2.txt','r');
bpp8_2 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR8_2.txt','r');
PSNR8_2 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM8_2.txt','r');
SSIM8_2 = fscanf(fileID,'%f\n');
fclose(fileID);

close all
figure
hold on
grid on
plot(bpp8_1, PSNR8_1, '*b', 'LineWidth', 1.5)
p1 = plot(bpp8_1, PSNR8_1, 'b', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), JPEG');
plot(bpp8_2, PSNR8_2, '*r', 'LineWidth', 1.5)
p2 = plot(bpp8_2, PSNR8_2, 'r', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), JPEG2000');

xlabel('bpp')
ylabel('PSNR')
title('PSNR(bpp)')
legend([p1, p2], 'Location', 'northwest')
%%
figure
hold on
grid on
plot(bpp8_1, SSIM8_1, '*b', 'LineWidth', 1.5)
p3 = plot(bpp8_1, SSIM8_1, 'b', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), JPEG');
plot(bpp8_2, SSIM8_2, '*r', 'LineWidth', 1.5)
p4 = plot(bpp8_2, SSIM8_2, 'r', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), JPEG2000');

xlabel('bpp')
ylabel('SSIM')
title('SSIM(bpp)')
legend([p3, p4], 'Location', 'northwest')