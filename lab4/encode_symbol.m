%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     64-разр€дное целочисленное ј–»‘ћ≈“»„≈— ќ≈  ќƒ»–ќ¬јЌ»≈     %
%                   —. ”мн€шкин, 2019.                          %
%                       www.miet.ru                             %
% –еализовано на базе статьи     Witten I., Neal R., Cleary J.  %
% Arithmetic Coding For Data Compression // Comm. ACM, Vol. 30, %
% No.6, June 1987. - pp.520-540.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   —крипт кодировани€ символа.
range = high - low +1;
high = low +idivide_(cum_freq(symbol+1)*range,cum_freq(NO_OF_SYMBOLS+1))-1;
low	 = low +idivide_(cum_freq(symbol)*range, cum_freq(NO_OF_SYMBOLS+1));
	% далее при необходимости†Ч вывод бита или меры от зацикливани€
	while 1	
		if (high < HALF) % —таршие биты low и high†Ч нулевые (оба)
			output_0_plus_follow; %вывод совпадающего старшего бита
        elseif (low >= HALF) % старшие биты low и high - единичные	 
			output_1_plus_follow;	% вывод старшего бита
			low  = low - HALF;				% сброс старшего бита в 0
			high = high - HALF;				% сброс старшего бита в 0
        else
            if (low >= FIRST_QTR) && (high < THIRD_QTR)
		% возможно зацикливание, выбрасываем второй по старшинству бит
                high = high - FIRST_QTR;	% high	=01...
                low = low - FIRST_QTR;		% low	=00...
                bits_to_follow = bits_to_follow +1;	
            else
                break		% вт€гивать новый бит рано
            end
        end
	    % старший бит в low и high нулевой, вт€гиваем новый бит  
		low = low + low;        %bitshift(low,1);       % вт€гиваем 0
		high= high + high +1;   %bitshift(high,1)+1;    % вт€гиваем 1
   end
