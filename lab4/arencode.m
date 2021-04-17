%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     64-��������� ������������� �������������� �����������     %
%                   �. ��������, 2019.                          %
%                       www.miet.ru                             %
% ����������� �� ���� ������     Witten I., Neal R., Cleary J.  %
% Arithmetic Coding For Data Compression // Comm. ACM, Vol. 30, %
% No.6, June 1987. - pp.520-540.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           ������ ��� ������� ������ 
in = fopen('ar0.cpp',"r");  % ������� ���� ��� ������
out = fopen('out.ar',"w");  % �������� ���� ������ ������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tstart = tic;
start_encoding;
while 1
    c = fread(in,1,'uint8');
    if feof(in) c = EOF_SYMBOL; 
    end
    symbol = c+1;
    encode_symbol;
    update_model;
    if c == EOF_SYMBOL break; end
end
finish_encoding;
TimeElapsed = toc(Tstart)
fclose(in);
fclose(out);