%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     64-разрядное целочисленное АРИФМЕТИЧЕСКОЕ КОДИРОВАНИЕ     %
%                   С. Умняшкин, 2019.                          %
%                       www.miet.ru                             %
% Реализовано на базе статьи     Witten I., Neal R., Cleary J.  %
% Arithmetic Coding For Data Compression // Comm. ACM, Vol. 30, %
% No.6, June 1987. - pp.520-540.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% closing encoder
bits_to_follow = bits_to_follow +1;
if ( low < FIRST_QTR )
        output_0_plus_follow;
else 
        output_1_plus_follow;
end;
buffer = bitshift(buffer,-bits_to_go);
fwrite(out,buffer,'uint16'); % записать незаполненный буфер