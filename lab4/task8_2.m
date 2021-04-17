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
x = im2double(imread('1.gif'));  %�������������� �����������
qstep = 0.077; % ��� ����������� ���-������������� (����������� ������)
Levels = [2 3 4 5]; % ���������� ������� ���-����������
for my_ind = 1:length(Levels)
    my_ind
y = ImDWT(x,Levels(my_ind));
imshow(log(0.001+abs(y)),[]);% ���������� �������-������

Q = ones(size(y))*qstep;    % ������� �����������
y = quantize_dead_zone(y,Q);          % ����� ���������� � ������ �����

fprintf(" �����������...\n");
out = fopen('jp2.ar',"w");  % �������� ���� ������ ������
start_encoding;
cum_freq(130:NO_OF_SYMBOLS+1) = cum_freq(130:NO_OF_SYMBOLS+1) +10000;
for l = 1:Levels(my_ind)
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
for l = 1:Levels(my_ind)
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
z = ImiDWT(y,Levels(my_ind));
%figure
%imshow(z,[]);
PSNR8_2(my_ind) = 10*log10(512*512/sum(sum((x-z).^2)))
SSIM8_2(my_ind) = ssim(im2uint8(x),im2uint8(z));
s = dir('jp2.ar');
the_size = s.bytes;
bpp8_2(my_ind) = 8 * the_size / 512^2
imwrite(im2uint8(z),strcat('82Q_Level=', num2str(Levels(my_ind)), '_bpp=', num2str(bpp8_2(my_ind)), '.gif'),'gif');
end
%%
 close all
 figure
 hold on
 grid on
plot(bpp8_2, PSNR8_2, '*r', 'LineWidth', 1.5)
p2 = plot(bpp8_2, PSNR8_2, 'r', 'LineWidth', 1.5, 'DisplayName', '�������� �������');
xlabel('bpp')
ylabel('PSNR')
title('PSNR(bpp)')
legend([p2], 'Location', 'northwest')
%%
% fileID = fopen('bpp8_2.txt','w');
% fprintf(fileID,'%.16f\n',bpp8_2);
% fclose(fileID);
% fileID = fopen('PSNR8_2.txt','w');
% fprintf(fileID,'%.16f\n',PSNR8_2);
% fclose(fileID);
% fileID = fopen('SSIM8_2.txt','w');
% fprintf(fileID,'%.16f\n',SSIM8_2);
% fclose(fileID);
%%
fileID = fopen('bpp8_2.txt','r');
bpp8_2 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR8_2.txt','r');
PSNR8_2 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM8_2.txt','r');
SSIM8_2 = fscanf(fileID,'%f\n');
fclose(fileID);