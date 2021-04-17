%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       JPEG-�������� ������� ����� ��� ������ �/� ���� �����������     %
%                   �. ��������, 2019.                                  %
%                       www.miet.ru                                     %
%        ����������� �� ������ �����������: ������ 512�512 !!!          %
%  ����� ������� ��� ������������ ���������� �������� ���������� �      %
%  ������������� ����������.                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
%clear
quality = [1 5 10 20 30 40 50 60 70 80 90 100];  % �������� �������� �������� ����� �� ��������� ~ 1..100
I = im2double(imread('1.gif'));  %�������������� �����������
for my_ind = 1:length(quality)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H4 = [(1/2)*[1  1  1  1];
      (1/2)*[1  1 -1 -1];
      (1/sqrt(2))*[1 -1  0  0];
      (1/sqrt(2))*[0  0  1 -1]];
 
H8 = zeros(8);
H8(1:4,1:4) = H4;
H8(5:8,5:8) = eye(4);

Temp = [1 1 0 0 0 0 0 0;
        0 0 1 1 0 0 0 0;
        0 0 0 0 1 1 0 0;
        0 0 0 0 0 0 1 1;
        1 -1 0 0 0 0 0 0;
        0 0 1 -1 0 0 0 0;
        0 0 0 0 1 -1 0 0;
        0 0 0 0 0 0 1 -1;];
    
T = (1/sqrt(2)) * H8 * Temp;

dct = @(x)T * x * T';

scale = 0.125*round(156*1.03125^quality(my_ind)); % ���������� - ���������. �����

B = blkproc(I,[8 8],dct) * scale; % ��������������� ����� ������������

% ��������� ������� �����������:
Q1 = 18*ones(8); %� ������ �5 �������: ���������� ����������� ����. ���  
Q =    [16   11   10   16   24   40   51   61
        12   12   14   19   26   58   60   55
        14   13   16   24   40   57   69   56
        14   17   22   29   51   87   80   62   
        18   22   37   56   68   109  103  77
        24   35   55   64   81   104  113  92
        49   64   78   87   103  121  120  101
        72   92   95   98   112  100  103  99];  % ������� �����������
     
% � ������ �4 �������: 
B1 = int16( blkproc(B,[8 8],@(x)quantize_dead_zone(x,Q)) ); % ��������� �����������

coef = zeros(8,8,4096,'uint8'); % ������ ��������������� ������������� ���
ind=1;
for x = 1:8:512
    for y = 1:8:512 
        % ���������� ����� 8�8 - ��� �������
        B1(x,y) = B1(x,y) - 128; % ������� DC-���������� � �������� ������
        coef(:,:,ind) = uint8( B1(x:(x+7),y:(y+7)) +128 ); % ��� ��� �����
        ind = ind + 1;
    end
end    
if  (max(max(B1)) > 127) || (min(min(B1)) < -128)  % 8 ��� �� ������!
    quality(my_ind)
    fprintf("Overflow! Decrease quality!\n");
    return
end



% ii � jj - ������ ����� � �������� ���-�������� ��� ���������� ��������    
ii = [1 1 2 3 2 1 1 2 3 4 5 4 3 2 1 1 2 3 4 5 6 7 6 5 4 3 2 1 .... 
 1 2 3 4 5 6 7 8 8 7 6 5 4 3 2 3 4 5 6 7 8 8 7 6 5 4 5 6 7 8 8 7 6 7 8 8];
jj = [ 1 2 1 1 2 3 4 3 2 1 1 2 3 4 5 6 5 4 3 2 1 1 2 3 4 5 6 7 8 ....
    7 6 5 4 3 2 1 2 3 4 5 6 7 8 8 7 6 5 4 3 4 5 6 7 8 8 7 6 5 6 7 8 8 7 8];
ii = ii(end:-1:1);
jj = jj(end:-1:1);

out = fopen('jp.ar',"w");  % �������� ���� ������ ������
start_encoding;

% � ������ �3 �������. ��� ������ ��������� ��������� ������:
cum_freq(130:NO_OF_SYMBOLS+1) = cum_freq(130:NO_OF_SYMBOLS+1) +6000;

fprintf("�����������...\n");
for ij=2:64   %� ������ �2 ������� ij=64:-1:2
    %  AC-������������ 
    i = ii(ij);
    j = jj(ij);
    for ind = 1:4096   
        symbol = uint16( coef(i,j,ind) ) +1;  
        encode_symbol;
        update_model;
    end
    fprintf("%5.0i\n",ij); % show progress
end    
for ind = 1:4096  %DC: ij=1  ��������� ����, ����� �������� ������������
    if (ind==1)         % ����������� ���
        deltaDC = int16( coef(1,1,ind)) +1;
    elseif (ind<=64)    % ����������� - ���������� ���� � (������) ������ 
        deltaDC = 128 + int16(coef(1,1,ind)) - int16(coef(1,1,ind-1)) +1;
    else                % ����������� - ���������� ���� � �������
        deltaDC = 128 + int16(coef(1,1,ind)) - int16(coef(1,1,ind-64)) +1;
    end
    if (deltaDC < 1) || (deltaDC > NO_OF_CHARS) % �������������!
        quality(my_ind)
        fprintf("Overflow at DPCM step detected! Decrease quality!\n");
        fprintf("deltaDC = %3.0i  must be [1..%3.0i]\n", deltaDC, NO_OF_CHARS);
        return;
    end
    symbol = uint16(deltaDC);
    encode_symbol;
    update_model;
end
finish_encoding;
fclose(out);
fprintf(" �������������...\n");

% ����� ���������� ������ ����    
in = fopen('jp.ar',"r");  % ������� ���� ������ ������
start_decoding;
% � ������ �3 �������: 
cum_freq(130:NO_OF_SYMBOLS+1) = cum_freq(130:NO_OF_SYMBOLS+1) +6000;

for ij=2:64   %� ������ �2 ������� ij=64:-1:2 
    i = ii(ij);
    j = jj(ij);
    for ind = 1:4096
            decode_symbol;
            update_model;
            coef(i,j,ind) = uint8(symbol -1);           
    end
    fprintf("%5.0i\n",ij); % show progress
end
for ind = 1:4096  %DC: ij=1 
    decode_symbol;
    update_model;
    if (ind==1)         % ����������� ���
        deltaDC = int16(symbol -1);
    elseif (ind<=64)    % ����������� - ���������� ���� � ������ 
        deltaDC = int16(symbol-1)  + int16(coef(1,1,ind-1)) - 128;
    else                % ����������� - ���������� ���� � �������
        deltaDC = int16(symbol-1)  + int16(coef(1,1,ind-64)) - 128;
    end
    coef(1,1,ind) = uint8(deltaDC);
end
fprintf("    1\n �����������-������������� ���������!\n\n");
fclose(in);
% ��������� �� �������������� ������ ���-������� ������ 
ind = 1;
for x = 1:8:512
    for y = 1:8:512 
        B1(x:(x+7),y:(y+7)) =  int16(coef(:,:,ind)) -128;
        B1(x,y) = B1(x,y) + 128; % DC -> unsigned
        ind = ind +1;
    end
end
    
% � ������ �4 �������:
B2 =(1/scale)* blkproc(B1,[8 8],@(x) dequantize_dead_zone(x,Q));  %�������������

T = T^(-1);
invdct = @(x)T * x * T';   
I2 = blkproc(B2,[8 8],invdct);      % �������������� ������ �����������

%imshow(I), figure, imshow(I2)
PSNR6(my_ind) = 10*log10(512*512/sum(sum((I-I2).^2)))
SSIM6(my_ind) = ssim(im2uint8(I),im2uint8(I2))
s = dir('jp.ar');
the_size = s.bytes;
bpp6(my_ind) = 8 * the_size / 512^2
imwrite(im2uint8(I2),strcat('6haar_Q_quality=', num2str(quality(my_ind)), '_bpp=', num2str(bpp6(my_ind)), '.gif'),'gif');
end
%%
close all
figure
hold on
grid on
plot(bpp6, PSNR6, '*r', 'LineWidth', 1.5)
p1 = plot(bpp6, PSNR6, 'r', 'LineWidth', 1.5, 'DisplayName', 'PSNR(bpp), haar');
xlabel('bpp')
ylabel('PSNR')
title('PSNR(bpp)')
legend([p1], 'Location', 'northwest')

figure
hold on
grid on
plot(bpp6, SSIM6, '*r', 'LineWidth', 1.5)
p2 = plot(bpp6, SSIM6, 'r', 'LineWidth', 1.5, 'DisplayName', 'SSIM(bpp), haar');
xlabel('bpp')
ylabel('SSIM')
title('SSIM(bpp)')
legend([p2], 'Location', 'northwest')
%%
% fileID = fopen('bpp6_h.txt','w');
% fprintf(fileID,'%.16f\n',bpp6);
% fclose(fileID);
% fileID = fopen('PSNR6_h.txt','w');
% fprintf(fileID,'%.16f\n',PSNR6);
% fclose(fileID);
% fileID = fopen('SSIM6_h.txt','w');
% fprintf(fileID,'%.16f\n',SSIM6);
% fclose(fileID);
%%
fileID = fopen('bpp6_h.txt','r');
bpp6 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR6_h.txt','r');
PSNR6 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('SSIM6_h.txt','r');
SSIM6 = fscanf(fileID,'%f\n');
fclose(fileID);