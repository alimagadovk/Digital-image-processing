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

fileID = fopen('bpp70.txt','r');
bpp70 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR70.txt','r');
PSNR70 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM70.txt','r');
SSIM70 = fscanf(fileID,'%f\n');
fclose(fileID);

fileID = fopen('bpp71.txt','r');
bpp71 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR71.txt','r');
PSNR71 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM71.txt','r');
SSIM71 = fscanf(fileID,'%f\n');
fclose(fileID);

fileID = fopen('bpp72.txt','r');
bpp72 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR72.txt','r');
PSNR72 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM72.txt','r');
SSIM72 = fscanf(fileID,'%f\n');
fclose(fileID);

fileID = fopen('bpp73.txt','r');
bpp73 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR73.txt','r');
PSNR73 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM73.txt','r');
SSIM73 = fscanf(fileID,'%f\n');
fclose(fileID);

fileID = fopen('bpp74.txt','r');
bpp74 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR74.txt','r');
PSNR74 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM74.txt','r');
SSIM74 = fscanf(fileID,'%f\n');
fclose(fileID);

close all
figure
hold on
grid on
plot(bpp51, PSNR51, '*b', 'LineWidth', 1.5)
p1 = plot(bpp51, PSNR51, 'b', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), task5, Q1');
plot(bpp52, PSNR52, '*r', 'LineWidth', 1.5)
p2 = plot(bpp52, PSNR52, 'r', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), task5, Q');
plot(bpp70, PSNR70, '*g', 'LineWidth', 1.5)
p3 = plot(bpp70, PSNR70, 'g', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), Levels = 1');
plot(bpp71, PSNR71, '*y', 'LineWidth', 5.5)
p4 = plot(bpp71, PSNR71, 'y', 'LineWidth', 5.5, 'DisplayName', 'PSNR(bpp), Levels = 2');
plot(bpp72, PSNR72, '*m', 'LineWidth', 1.5)
p5 = plot(bpp72, PSNR72, 'm', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), Levels = 3');
plot(bpp73, PSNR73, '*k', 'LineWidth', 1.5)
p6 = plot(bpp73, PSNR73, 'k', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), Levels = 4');
plot(bpp74, PSNR74, '*c', 'LineWidth', 1.5)
p7 = plot(bpp74, PSNR74, 'c', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), Levels = 5');
xlabel('bpp')
ylabel('PSNR')
title('PSNR(bpp)')
legend([p1, p2, p3, p4, p5, p6, p7], 'Location', 'northwest')
%%
figure
hold on
grid on
plot(bpp51, SSIM51, '*b', 'LineWidth', 1.5)
p1 = plot(bpp51, SSIM51, 'b', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), task5, Q1');
plot(bpp52, SSIM52, '*r', 'LineWidth', 1.5)
p2 = plot(bpp52, SSIM52, 'r', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), task5, Q');
plot(bpp70, SSIM70, '*g', 'LineWidth', 1.5)
p3 = plot(bpp70, SSIM70, 'g', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), Levels = 1');
plot(bpp71, SSIM71, '*y', 'LineWidth', 5.5)
p4 = plot(bpp71, SSIM71, 'y', 'LineWidth', 5.5, 'DisplayName', 'SSIM(bpp), Levels = 2');
plot(bpp72, SSIM72, '*m', 'LineWidth', 1.5)
p5 = plot(bpp72, SSIM72, 'm', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), Levels = 3');
plot(bpp73, SSIM73, '*k', 'LineWidth', 1.5)
p6 = plot(bpp73, SSIM73, 'k', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), Levels = 4');
plot(bpp74, SSIM74, '*c', 'LineWidth', 1.5)
p7 = plot(bpp74, SSIM74, 'c', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), Levels = 5');
xlabel('bpp')
ylabel('SSIM')
title('SSIM(bpp)')
legend([p1, p2, p3, p4, p5, p6, p7], 'Location', 'southeast')