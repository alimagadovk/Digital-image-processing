%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Учебный вейвлет-кодек для сжатия ч/б фотографических изображений   %
%                   С. Умняшкин, 2019.                                  %
%                       www.miet.ru                                     %
%        Ограничения на размер изображения: количество строк и          %
%            количество столбцов должно быть кратно 16.                 %
%  После дискретного вейвлет-преобразования biort4.4 коэффициенты       %
%    разложения скалярно квантуются и арифметически кодируются.         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Скрипт для выполнения пункта №7 домашнего задания
        
x = im2double(imread('1.gif'));  %обрабатываемое изображение
qstep = 0.077; % шаг квантования ДВП-коэффициентов (регулировка ошибки)
Levels = 4; % Количество уровней ДВП-разложения
y = ImDWT(x,Levels);
imshow(log(0.001+abs(y)),[]);% отображаем вейвлет-спектр

Q = ones(size(y))*qstep;    % Матрица квантования
y = quantize_dead_zone(y,Q);          % Лучше квантовать с мёртвой зоной

fprintf(" Кодирование...\n");
out = fopen('jp2.ar',"w");  % выходной файл сжатых данных
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
subband = y; % это беззнаковые коэффициетны НЧ-саббэнда
% reset model for different LL statistics
cum_freq = uint64(0:NO_OF_SYMBOLS);
encode_subband;
finish_encoding;
fclose(out);

%%%%%%%%%%%%%%%%% Далее декодирование %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf(" LL done\n\n Декодирование...\n");
in = fopen('jp2.ar',"r");  % входной файл сжатых данных
start_decoding;
cum_freq(130:NO_OF_SYMBOLS+1) = cum_freq(130:NO_OF_SYMBOLS+1) +10000;
y = zeros(512);   % ДВП - спектр
z = y;            % Восстановленное изображение
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
y(1:size(z,1),1:size(z,2)) = subband; % это беззнаковые коэффициетны
finish_encoding;
fclose(in);
fprintf(" LL done\n\n Кодирование-декодирование завершено!\n\n");

y = dequantize_dead_zone(y,Q);
z = ImiDWT(y,Levels);
figure
imshow(z,[]);
PSNR = 10*log10(512*512/sum(sum((x-z).^2)))
s = dir('jp2.ar');
the_size = s.bytes;
bpp = 8 * the_size / 512^2
