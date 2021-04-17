%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     64-разрядное целочисленное АРИФМЕТИЧЕСКОЕ КОДИРОВАНИЕ     %
%                   С. Умняшкин, 2019.                          %
%                       www.miet.ru                             %
% Реализовано на базе статьи     Witten I., Neal R., Cleary J.  %
% Arithmetic Coding For Data Compression // Comm. ACM, Vol. 30, %
% No.6, June 1987. - pp.520-540.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
common;  % Globals
bits_to_go = uint8(0);
garbage_bits  = uint8(0);
bit = uint64(0);
value = uint64(0);
for i = 1:BITS_IN_REGISTER
    input_bit;
	value = bitshift(value,1) + bit;
end