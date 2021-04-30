%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    ������� �������-����� ��� ������ �/� ��������������� �����������   %
%                   �. ��������, 2019.                                  %
%                       www.miet.ru                                     %
%        ����������� �� ������ �����������: ���������� ����� �          %
%            ���������� �������� ������ ���� ������ 16.                 %
%  ����� ����������� �������-�������������� biort4.4 ������������       %
%    ���������� �������� ���������� � ������������� ����������.         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % ������ ��� ���������� ������ �7 ��������� �������
clear
clc
x = im2double(imread('1.gif'));  %�������������� �����������
qstep = [0.0769 0.08 0.085 0.09 0.25 0.3 0.35 0.4]; % ��� ����������� ���-������������� (����������� ������)
Levels = 2; % ���������� ������� ���-����������
for my_ind = 1:length(qstep)
y = ImDWT(x,Levels);
imshow(log(0.001+abs(y)),[]);% ���������� �������-������

Q = ones(size(y))*qstep(my_ind);    % ������� �����������
y = quantize_dead_zone(y,Q);          % ����� ���������� � ������ �����

fprintf(" �����������...\n");
out = fopen('jp2.ar',"w");  % �������� ���� ������ ������
start_encoding;
cum_freq(130:NO_OF_SYMBOLS+1) = cum_freq(130:NO_OF_SYMBOLS+1) +10000;
for l = 1:Levels
    subband = y(1+ size(y,1)/2 : size(y,1), 1+size(y,2)/2 : size(y,2)) +128; %d
    encode_subband;
    fprintf("%2.0i diagonal done\n", l);
    subband = y(1+ size(y,1)/2 : size(y,1), 1:size(y,2)/2) +128; %v
    encode_subband;
    fprintf("%2.0i vertical done\n",l );
    subband = y(1:size(y,1)/2, 1+size(y,2)/2 : size(y,2)) +128;  %h
    encode_subband; 
    fprintf("%2.0i horizontal done\n", l);
    y = y(1:size(y,1)/2, 1:size(y,2)/2); %a
end
subband = y; % ��� ����������� ������������ ��-��������
% reset model for different LL statistics
cum_freq = uint64(0:NO_OF_SYMBOLS);
encode_subband;
finish_encoding;
fclose(out);

%%%%%%%%%%%%%%%%% ����� ������������� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf(" LL done\n\n �������������...\n");
in = fopen('jp2.ar',"r");  % ������� ���� ������ ������
start_decoding;
cum_freq(130:NO_OF_SYMBOLS+1) = cum_freq(130:NO_OF_SYMBOLS+1) +10000;
y = zeros(512);   % ��� - ������
z = y;            % ��������������� �����������
subband = y;
for l = 1:Levels
    subband = zeros(size(z)/2);
    decode_subband;
    z(1+ size(z,1)/2 : size(z,1), 1+size(z,2)/2 : size(z,2)) = subband -128; %d
    fprintf("%2.0i diagonal done\n", l);
    decode_subband;
    z(1+ size(z,1)/2 : size(z,1), 1:size(z,2)/2) = subband -128; %v
    fprintf("%2.0i vertical done\n",l );
    decode_subband;
    z(1:size(z,1)/2, 1+size(z,2)/2 : size(z,2)) = subband -128;  %h
    fprintf("%2.0i horizontal done\n", l);
    y(1:size(z,1),1:size(z,2)) = z;
    z = zeros(size(z)/2); %a
end
% reset model for LL-subband
cum_freq = uint64(0:NO_OF_SYMBOLS); 
decode_subband;
y(1:size(z,1),1:size(z,2)) = subband; % ��� ����������� ������������
finish_encoding;
fclose(in);
fprintf(" LL done\n\n �����������-������������� ���������!\n\n");

y = dequantize_dead_zone(y,Q);
z = ImiDWT(y,Levels);
%figure
%imshow(z,[]);
PSNR7(my_ind) = 10*log10(512*512/sum(sum((x-z).^2)))
SSIM7(my_ind) = ssim(im2uint8(x),im2uint8(z))
s = dir('jp2.ar');
the_size = s.bytes;
bpp7(my_ind) = 8 * the_size / 512^2
imwrite(im2uint8(z),strcat('7Q_Level=', num2str(Levels), '_qstep=', num2str(qstep(my_ind)), '_bpp=', num2str(bpp7(my_ind)), '.gif'),'gif');
end
%%
close all
figure
hold on
grid on
plot(bpp7, PSNR7, '*r', 'LineWidth', 1.5)
p1 = plot(bpp7, PSNR7, 'r', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), task7');
xlabel('bpp')
ylabel('PSNR')
title('PSNR(bpp)')
legend([p1], 'Location', 'northwest')

figure
hold on
grid on
plot(bpp7, SSIM7, '*r', 'LineWidth', 1.5)
p1 = plot(bpp7, SSIM7, 'r', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), task7');
xlabel('bpp')
ylabel('SSIM')
title('SSIM(bpp)')
legend([p1], 'Location', 'northwest')
%%
% fileID = fopen('bpp71.txt','w');
% fprintf(fileID,'%.16f\n',bpp7);
% fclose(fileID);
% fileID = fopen('PSNR71.txt','w');
% fprintf(fileID,'%.16f\n',PSNR7);
% fclose(fileID);
% fileID = fopen('SSIM71.txt','w');
% fprintf(fileID,'%.16f\n',SSIM7);
% fclose(fileID);
%%
fileID = fopen('bpp71.txt','r');
bpp7 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR71.txt','r');
PSNR7 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM71.txt','r');
SSIM7 = fscanf(fileID,'%f\n');
fclose(fileID);