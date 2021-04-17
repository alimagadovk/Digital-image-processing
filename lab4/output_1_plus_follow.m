%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     64-разрядное целочисленное АРИФМЕТИЧЕСКОЕ КОДИРОВАНИЕ     %
%                   С. Умняшкин, 2019.                          %
%                       www.miet.ru                             %
% Реализовано на базе статьи     Witten I., Neal R., Cleary J.  %
% Arithmetic Coding For Data Compression // Comm. ACM, Vol. 30, %
% No.6, June 1987. - pp.520-540.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
buffer = bitshift(buffer,-1) + 32768; % в битовый буфер (2 байта)
bits_to_go = bits_to_go -1;
if bits_to_go == 0 % битовый буфер заполнен, сброс буфера
	fwrite(out, buffer, 'uint16');
	bits_to_go = 16;
end

while bits_to_follow %> 0
	buffer = bitshift(buffer,-1);
    bits_to_go = bits_to_go -1;
    if bits_to_go == 0 
            fwrite(out, buffer, 'uint16');
            bits_to_go = 16;
    end
	bits_to_follow = bits_to_follow -1;
end
