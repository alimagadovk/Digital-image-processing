%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     64-��������� ������������� �������������� �����������     %
%                   �. ��������, 2019.                          %
%                       www.miet.ru                             %
% ����������� �� ���� ������     Witten I., Neal R., Cleary J.  %
% Arithmetic Coding For Data Compression // Comm. ACM, Vol. 30, %
% No.6, June 1987. - pp.520-540.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   ������ ����������� �������.
range = high - low +1;
high = low +idivide_(cum_freq(symbol+1)*range,cum_freq(NO_OF_SYMBOLS+1))-1;
low	 = low +idivide_(cum_freq(symbol)*range, cum_freq(NO_OF_SYMBOLS+1));
	% ����� ��� ������������蠗 ����� ���� ��� ���� �� ������������
	while 1	
		if (high < HALF) % ������� ���� low � high�� ������� (���)
			output_0_plus_follow; %����� ������������ �������� ����
        elseif (low >= HALF) % ������� ���� low � high - ���������	 
			output_1_plus_follow;	% ����� �������� ����
			low  = low - HALF;				% ����� �������� ���� � 0
			high = high - HALF;				% ����� �������� ���� � 0
        else
            if (low >= FIRST_QTR) && (high < THIRD_QTR)
		% �������� ������������, ����������� ������ �� ����������� ���
                high = high - FIRST_QTR;	% high	=01...
                low = low - FIRST_QTR;		% low	=00...
                bits_to_follow = bits_to_follow +1;	
            else
                break		% ��������� ����� ��� ����
            end
        end
	    % ������� ��� � low � high �������, ��������� ����� ���  
		low = low + low;        %bitshift(low,1);       % ��������� 0
		high= high + high +1;   %bitshift(high,1)+1;    % ��������� 1
   end
