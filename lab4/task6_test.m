clc
clear
close all

fileID = fopen('bpp6_w.txt','r');
bpp6_w = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR6_w.txt','r');
PSNR6_w = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM6_w.txt','r');
SSIM6_w = fscanf(fileID,'%f\n');
fclose(fileID);

fileID = fopen('bpp6_h.txt','r');
bpp6_h = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR6_h.txt','r');
PSNR6_h = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM6_h.txt','r');
SSIM6_h = fscanf(fileID,'%f\n');
fclose(fileID);

fileID = fopen('bpp6_d.txt','r');
bpp6_d = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR6_d.txt','r');
PSNR6_d = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM6_d.txt','r');
SSIM6_d = fscanf(fileID,'%f\n');
fclose(fileID);

close all
figure
hold on
grid on
plot(bpp6_w, PSNR6_w, '*b', 'LineWidth', 1.5)
p1 = plot(bpp6_w, PSNR6_w, 'b', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), walsh');
plot(bpp6_h, PSNR6_h, '*r', 'LineWidth', 1.5)
p2 = plot(bpp6_h, PSNR6_h, 'r', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), haar');
plot(bpp6_d, PSNR6_d, '*g', 'LineWidth', 1.5)
p3 = plot(bpp6_d, PSNR6_d, 'g', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), dpct');
xlabel('bpp')
ylabel('PSNR')
title('PSNR(bpp)')
legend([p1, p2, p3], 'Location', 'northwest')

figure
hold on
grid on
plot(bpp6_w, SSIM6_w, '*b', 'LineWidth', 1.5)
p4 = plot(bpp6_w, SSIM6_w, 'b', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), walsh');
plot(bpp6_h, SSIM6_h, '*r', 'LineWidth', 1.5)
p5 = plot(bpp6_h, SSIM6_h, 'r', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), haar');
plot(bpp6_d, SSIM6_d, '*g', 'LineWidth', 1.5)
p6 = plot(bpp6_d, SSIM6_d, 'g', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), dpct');
xlabel('bpp')
ylabel('SSIM')
title('SSIM(bpp)')
legend([p4, p5, p6], 'Location', 'northwest')