clc
clear
close all

fileID = fopen('bpp51_task7.txt','r');
bpp51 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR51_task7.txt','r');
PSNR51 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM51_task7.txt','r');
SSIM51 = fscanf(fileID,'%f\n');
fclose(fileID);

fileID = fopen('bpp52_task7.txt','r');
bpp52 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR52_task7.txt','r');
PSNR52 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM52_task7.txt','r');
SSIM52 = fscanf(fileID,'%f\n');
fclose(fileID);

fileID = fopen('bpp7.txt','r');
bpp7 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR7.txt','r');
PSNR7 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM7.txt','r');
SSIM7 = fscanf(fileID,'%f\n');
fclose(fileID);

close all
figure
hold on
grid on
plot(bpp51, PSNR51, '*b', 'LineWidth', 1.5)
p1 = plot(bpp51, PSNR51, 'b', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), task5, Q1');
plot(bpp52, PSNR52, '*r', 'LineWidth', 1.5)
p2 = plot(bpp52, PSNR52, 'r', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), task5, Q');
plot(bpp7, PSNR7, '*g', 'LineWidth', 1.5)
p3 = plot(bpp7, PSNR7, 'g', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), task7');
xlabel('bpp')
ylabel('PSNR')
title('PSNR(bpp)')
legend([p1, p2, p3], 'Location', 'northwest')
%%
figure
hold on
grid on
plot(bpp51, SSIM51, '*b', 'LineWidth', 1.5)
p4 = plot(bpp51, SSIM51, 'b', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), walsh');
plot(bpp52, SSIM52, '*r', 'LineWidth', 1.5)
p5 = plot(bpp52, SSIM52, 'r', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), haar');
plot(bpp7, SSIM7, '*g', 'LineWidth', 1.5)
p6 = plot(bpp7, SSIM7, 'g', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), dpct');
xlabel('bpp')
ylabel('SSIM')
title('SSIM(bpp)')
legend([p4, p5, p6], 'Location', 'northwest')