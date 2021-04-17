%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     64-ðàçðÿäíîå öåëî÷èñëåííîå ÀÐÈÔÌÅÒÈ×ÅÑÊÎÅ ÊÎÄÈÐÎÂÀÍÈÅ     %
%                   Ñ. Óìíÿøêèí, 2019.                          %
%                       www.miet.ru                             %
% Ðåàëèçîâàíî íà áàçå ñòàòüè     Witten I., Neal R., Cleary J.  %
% Arithmetic Coding For Data Compression // Comm. ACM, Vol. 30, %
% No.6, June 1987. - pp.520-540.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	if bits_to_go == 0
		buffer = uint16(fread(in,1,'uint16'));
		if feof(in)
			garbage_bits = garbage_bits +1; 
			if (garbage_bits > BITS_IN_REGISTER - 2)
				fprintf("ERROR IN COMPRESSED FILE ! \n");				
                return;
            end
			bits_to_go = 1;
            buffer = uint16(0);
        else         
            bits_to_go = 16;
        end
    end
    bit = uint64(bitget(buffer,1));
	buffer = bitshift(buffer,-1);
	bits_to_go = bits_to_go - 1;
