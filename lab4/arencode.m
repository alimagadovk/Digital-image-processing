%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     64-разрядное целочисленное АРИФМЕТИЧЕСКОЕ КОДИРОВАНИЕ     %
%                   С. Умняшкин, 2019.                          %
%                       www.miet.ru                             %
% Реализовано на базе статьи     Witten I., Neal R., Cleary J.  %
% Arithmetic Coding For Data Compression // Comm. ACM, Vol. 30, %
% No.6, June 1987. - pp.520-540.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           Скрипт для запуска кодера 
in = fopen('ar0.cpp',"r");  % входной файл для сжатия
out = fopen('out.ar',"w");  % выходной файл сжатых данных
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tstart = tic;
start_encoding;
while 1
    c = fread(in,1,'uint8');
    if feof(in) c = EOF_SYMBOL; 
    end
    symbol = c+1;
    encode_symbol;
    update_model;
    if c == EOF_SYMBOL break; end
end
finish_encoding;
TimeElapsed = toc(Tstart)
fclose(in);
fclose(out);