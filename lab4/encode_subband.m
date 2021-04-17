% ������������ ������ � jp2.m
% �������������� ����������� ��������� ������� subband
% ���������� ������ ����� ����� �������� �� ��������� 0..255
for i = 1: size(subband,1)
        for j = 1: size(subband,2)
            symbol = uint16(subband(i,j)+1);
            if (symbol > NO_OF_SYMBOLS)
                fprintf("Overflow! Decrease quality!\n");
                return;
            end
            encode_symbol;
            update_model;
        end
    end