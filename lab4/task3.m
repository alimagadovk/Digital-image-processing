%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       JPEG-подобный учебный кодек для сжатия ч/б фото изображений     %
%                   С. Умняшкин, 2019.                                  %
%                       www.miet.ru                                     %
%        Ограничения на размер изображения: только 512х512 !!!          %
%  После блочных ДКП коэффициенты разложения скалярно квантуются и      %
%  арифметически кодируются.                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
quality = [1 5 10 20 30 40 50 60 70 80 90 100];  % Параметр качества выбираем целым из диапазона ~ 1..100
I = im2double(imread('1.gif'));  %обрабатываемое изображение
for my_ind = 1:length(quality)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T = dctmtx(8); % К ПУНКТУ №6 ЗАДАНИЯ: Заменить преобразование
dct = @(x)T * x * T';

scale = 0.125*round(156*1.03125^quality(my_ind)); % нормировка - экспоненц. шкала

B = blkproc(I,[8 8],dct) * scale; % масштабирование перед квантованием

% Возможные матрицы квантования:
Q1 = 18*ones(8); %К ПУНКТУ №5 ЗАДАНИЯ: одинаковое квантование коэф. ДКП  
Q =    [16   11   10   16   24   40   51   61
        12   12   14   19   26   58   60   55
        14   13   16   24   40   57   69   56
        14   17   22   29   51   87   80   62   
        18   22   37   56   68   109  103  77
        24   35   55   64   81   104  113  92
        49   64   78   87   103  121  120  101
        72   92   95   98   112  100  103  99];  % Матрица Пеннебакера
     
% К ПУНКТУ №4 ЗАДАНИЯ: 
B1 = int16( blkproc(B,[8 8],@(x)quantize(x,Q)) ); % скалярное квантование

coef = zeros(8,8,4096,'uint8'); % массив проквантованных коэффициентов ДКП
ind=1;
for x = 1:8:512
    for y = 1:8:512 
        % перебираем блоки 8х8 - ДКП спектры
        B1(x,y) = B1(x,y) - 128; % перевод DC-компоненты в знаковый формат
        coef(:,:,ind) = uint8( B1(x:(x+7),y:(y+7)) +128 ); % ВСЕ без знака
        ind = ind + 1;
    end
end    
if  (max(max(B1)) > 127) || (min(min(B1)) < -128)  % 8 бит не хватит!
    quality(my_ind)
    fprintf("Overflow! Decrease quality!\n");
    return
end



% ii и jj - номера строк и столбцов ДКП-спектров при считывании зигзагом    
ii = [1 1 2 3 2 1 1 2 3 4 5 4 3 2 1 1 2 3 4 5 6 7 6 5 4 3 2 1 .... 
 1 2 3 4 5 6 7 8 8 7 6 5 4 3 2 3 4 5 6 7 8 8 7 6 5 4 5 6 7 8 8 7 6 7 8 8];
jj = [ 1 2 1 1 2 3 4 3 2 1 1 2 3 4 5 6 5 4 3 2 1 1 2 3 4 5 6 7 8 ....
    7 6 5 4 3 2 1 2 3 4 5 6 7 8 8 7 6 5 4 3 4 5 6 7 8 8 7 6 5 6 7 8 8 7 8];
ii = ii(end:-1:1);
jj = jj(end:-1:1);

out = fopen('jp.ar',"w");  % выходной файл сжатых данных
start_encoding;

% К ПУНКТУ №3 ЗАДАНИЯ. Для лучшей начальной настройки модели:
cum_freq(130:NO_OF_SYMBOLS+1) = cum_freq(130:NO_OF_SYMBOLS+1) +6000;

fprintf("Кодирование...\n");
for ij=2:64   %К ПУНКТУ №2 ЗАДАНИЯ ij=64:-1:2
    %  AC-коэффициенты 
    i = ii(ij);
    j = jj(ij);
    for ind = 1:4096   
        symbol = uint16( coef(i,j,ind) ) +1;  
        encode_symbol;
        update_model;
    end
    fprintf("%5.0i\n",ij); % show progress
end    
for ind = 1:4096  %DC: ij=1  Применяем ДИКМ, здесь возможно переполнение
    if (ind==1)         % предыстории нет
        deltaDC = int16( coef(1,1,ind)) +1;
    elseif (ind<=64)    % предыстория - предыдущий блок в (первой) строке 
        deltaDC = 128 + int16(coef(1,1,ind)) - int16(coef(1,1,ind-1)) +1;
    else                % предыстория - предыдущий блок в столбце
        deltaDC = 128 + int16(coef(1,1,ind)) - int16(coef(1,1,ind-64)) +1;
    end
    if (deltaDC < 1) || (deltaDC > NO_OF_CHARS) % переполненние!
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
fprintf(" Декодирование...\n");

% далее декодируем сжатый файл    
in = fopen('jp.ar',"r");  % входной файл сжатых данных
start_decoding;
% К ПУНКТУ №3 ЗАДАНИЯ: 
cum_freq(130:NO_OF_SYMBOLS+1) = cum_freq(130:NO_OF_SYMBOLS+1) +6000;

for ij=2:64   %К ПУНКТУ №2 ЗАДАНИЯ ij=64:-1:2 
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
    if (ind==1)         % предыстории нет
        deltaDC = int16(symbol -1);
    elseif (ind<=64)    % предыстория - предыдущий блок в строке 
        deltaDC = int16(symbol-1)  + int16(coef(1,1,ind-1)) - 128;
    else                % предыстория - предыдущий блок в столбце
        deltaDC = int16(symbol-1)  + int16(coef(1,1,ind-64)) - 128;
    end
    coef(1,1,ind) = uint8(deltaDC);
end
fprintf("    1\n Кодирование-декодирование завершено!\n\n");
fclose(in);
% формируем из декодированных данных ДКП-спектры блоков 
ind = 1;
for x = 1:8:512
    for y = 1:8:512 
        B1(x:(x+7),y:(y+7)) =  int16(coef(:,:,ind)) -128;
        B1(x,y) = B1(x,y) + 128; % DC -> unsigned
        ind = ind +1;
    end
end
    
% К ПУНКТУ №4 ЗАДАНИЯ:
B2 =(1/scale)* blkproc(B1,[8 8],@(x) dequantize(x,Q));  %деквантование

invdct = @(x)T' * x * T;   
I2 = blkproc(B2,[8 8],invdct);      % восстановление блоков изображения

%imshow(I), figure, imshow(I2)
PSNR3(my_ind) = 10*log10(512*512/sum(sum((I-I2).^2)))
s = dir('jp.ar');
the_size = s.bytes;
bpp3(my_ind) = 8 * the_size / 512^2
end
%%
close all
figure
hold on
grid on
plot(bpp1, PSNR1, '*', 'LineWidth', 1.25)
p1 = plot(bpp1, PSNR1, 'b', 'LineWidth', 1.25, 'DisplayName', 'Прямой порядок');

%plot(bpp2, PSNR2, '*r', 'LineWidth', 1.25)
%p2 = plot(bpp2, PSNR2, 'r', 'LineWidth', 1.25, 'DisplayName', 'Обратный порядок');

plot(bpp3, PSNR3, '*m', 'LineWidth', 1.25)
p3 = plot(bpp3, PSNR3, 'm', 'LineWidth', 1.25, 'DisplayName', 'Доинициализированная модель');

%plot(bpp32, PSNR32, '*g', 'LineWidth', 1.25)
%p32 = plot(bpp32, PSNR32, 'g', 'LineWidth', 1.25, 'DisplayName', 'Доинициализированная модель, обр. порядок');
xlabel('bpp')
ylabel('PSNR')
title('PSNR(bpp)')
legend([p1,p3], 'Location', 'northwest')
%%
% fileID = fopen('bpp3.txt','w');
% fprintf(fileID,'%.16f\n',bpp3);
% fclose(fileID);
% fileID = fopen('PSNR3.txt','w');
% fprintf(fileID,'%.16f\n',PSNR3);
% fclose(fileID);
%%
fileID = fopen('bpp1.txt','r');
bpp1 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR1.txt','r');
PSNR1 = fscanf(fileID,'%f\n');
fclose(fileID);

fileID = fopen('bpp2.txt','r');
bpp2 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR2.txt','r');
PSNR2 = fscanf(fileID,'%f\n');
fclose(fileID);

fileID = fopen('bpp3.txt','r');
bpp3 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR3.txt','r');
PSNR3 = fscanf(fileID,'%f\n');
fclose(fileID);

fileID = fopen('bpp32.txt','r');
bpp32 = fscanf(fileID,'%f\n');
fclose(fileID);
fileID = fopen('PSNR32.txt','r');
PSNR32 = fscanf(fileID,'%f\n');
fclose(fileID);