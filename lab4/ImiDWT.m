function [x] = ImiDWT(y, l)
% ����������� ���������� ��������� ���������� l-���������� ��� biort4.4 
% ������� y � ����������� ����������� �������� x, y.
% �����: ����� ����� � ����� �������� �� ������� ������� ������ ����
% ������� 2^l, ��� ��������� �������� l:  1..6

if nargin < 2
    l = 1; % default
end

if l<0 l=uint8(0);
elseif l>6 l=uint8(6);
else l = uint8(l);
end
    
if (l==0) x=y; return;
end

a = y(1:size(y,1)/2, 1:size(y,2)/2);
a =  ImiDWT( a, l-1 );
b =  y(1:size(y,1)/2, size(y,2)/2 + 1   :  size(y,2));
c =  y(size(y,1)/2 + 1: size(y,1), 1:size(y,2)/2);
d =  y(size(y,1)/2 + 1: size(y,1), size(y,2)/2 + 1   :  size(y,2));
x = myidwt2(a, b, c, d);
    
