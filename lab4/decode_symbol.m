%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     64-разрядное целочисленное АРИФМЕТИЧЕСКОЕ КОДИРОВАНИЕ     %
%                   С. Умняшкин, 2019.                          %
%                       www.miet.ru                             %
% Реализовано на базе статьи     Witten I., Neal R., Cleary J.  %
% Arithmetic Coding For Data Compression // Comm. ACM, Vol. 30, %
% No.6, June 1987. - pp.520-540.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Скрипт декодирования символа.
range = high - low +1;
cum = idivide_( (value - low +1) * cum_freq(NO_OF_SYMBOLS+1) -1, range);
symbol = uint16(sum(cum_freq<=cum));    
% пересчет границ
high = low +idivide_(range*cum_freq(symbol+1), cum_freq(NO_OF_SYMBOLS+1))-1;
low  = low +idivide_(range*cum_freq(symbol), cum_freq(NO_OF_SYMBOLS+1));
    while 1
		if (high < HALF) 
        elseif (low >= HALF) 
			value = value - HALF;
			low = low - HALF;
			high = high - HALF;
        else
            if (low >= FIRST_QTR) && (high < THIRD_QTR)
                value = value - FIRST_QTR;
                low = low - FIRST_QTR;
                high = high - FIRST_QTR;
            else
                break;
            end
        end
		low = low + low;                %bitshift(low,1); 
		high = high + high +1;          %bitshift(high,1) + 1;
        input_bit;
		value = value + value + bit;    %bitshift(value,1) + bit; 
    end
