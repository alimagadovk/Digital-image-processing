%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     64-разрядное целочисленное АРИФМЕТИЧЕСКОЕ КОДИРОВАНИЕ     %
%                   С. Умняшкин, 2019.                          %
%                       www.miet.ru                             %
% Реализовано на базе статьи     Witten I., Neal R., Cleary J.  %
% Arithmetic Coding For Data Compression // Comm. ACM, Vol. 30, %
% No.6, June 1987. - pp.520-540.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Скрипт глобальных констант и переменных

%constants
BITS_IN_REGISTER = uint8(48);	
TOP_VALUE = uint64(bitshift(1,BITS_IN_REGISTER) -1);    % 1111...1
FIRST_QTR = uint64(bitshift(TOP_VALUE,-2) +1);          % 0100...0
HALF = uint64(2*FIRST_QTR);                             % 1000...0
THIRD_QTR = uint64(3*FIRST_QTR);                        % 1100...0
MAX_FREQUENCY =	uint32(bitshift(1, 15));
NO_OF_CHARS	= uint16(256);
EOF_SYMBOL	= uint16(NO_OF_CHARS);        % char-коды: 0..NO_OF_CHARS-1 
NO_OF_SYMBOLS = uint16(NO_OF_CHARS+1);	

%variables
low = uint64(0);
high = uint64(TOP_VALUE);
cum = uint64(0);
range = uint64(high+1);
symbol = uint16(0);
buffer = uint16(0);
c = uint16(0);
% initialize model
cum_freq = uint64(0:NO_OF_SYMBOLS); 