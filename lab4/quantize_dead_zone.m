function c = quantize_dead_zone(a,b)
% � ������ �4 �������
  % c = round(a./b);                % ����������� �����������
   c = sign(a).*fix(abs(a)./b);    % ����������� � ������� �����