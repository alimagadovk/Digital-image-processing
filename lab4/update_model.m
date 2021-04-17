%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     64-��������� ������������� �������������� �����������     %
%                   �. ��������, 2019.                          %
%                       www.miet.ru                             %
% ����������� �� ���� ������     Witten I., Neal R., Cleary J.  %
% Arithmetic Coding For Data Compression // Comm. ACM, Vol. 30, %
% No.6, June 1987. - pp.520-540.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ������ ���������� ������ ������.
if cum_freq(NO_OF_SYMBOLS+1) == MAX_FREQUENCY
    cum = uint64(0);
    for k=1:NO_OF_SYMBOLS
        fr = bitshift(cum_freq(k+1)-cum_freq(k)+1, -1);
		cum_freq(k) = cum;
		cum = cum + fr;
    end
    cum_freq(NO_OF_SYMBOLS+1)=cum;
end
cum_freq(symbol+1:NO_OF_SYMBOLS+1) = cum_freq(symbol+1:NO_OF_SYMBOLS+1) +1;