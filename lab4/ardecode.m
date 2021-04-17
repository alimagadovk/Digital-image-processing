%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     64-разрядное целочисленное АРИФМЕТИЧЕСКОЕ КОДИРОВАНИЕ     %
%                   С. Умняшкин, 2019.                          %
%                       www.miet.ru                             %
% Реализовано на базе статьи     Witten I., Neal R., Cleary J.  %
% Arithmetic Coding For Data Compression // Comm. ACM, Vol. 30, %
% No.6, June 1987. - pp.520-540.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           Скрипт для запуска декодера
in = fopen('out.ar',"r");      %  Сжатые данные
out = fopen('out.txt',"w");   %  Деодированные данные
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tstart = tic;
start_decoding;
while 1
    decode_symbol;
    update_model;
    c = symbol-1;
    if c==EOF_SYMBOL break, end
    fwrite(out,c,'uint8');
end;
TimeElapsed = toc (Tstart)
fclose(in);
fclose(out);