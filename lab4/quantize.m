function c = quantize(a,b)
% � ������ �4 �������
    c = round(a./b);                % ����������� �����������
  % c = sign(a).*fix(abs(a)./b);    % ����������� � ������� �����