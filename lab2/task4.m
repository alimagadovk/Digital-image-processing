clc
clear
close all
M = 100000;
a = floor(rand(1, M)*10);
b = sum(floor(rand(100, M)*10));
c = [a(1:end/2),b(1:end/2)];
d = zeros(1,100000);
d(1:2:end - 1) = a(1:end/2);
d(2:2:end) = b(1:end/2);
figure
hist(a)
figure
hist(b)
%%
file = fopen('row1.bin', 'w');
fwrite(file, a);
fclose(file);
file = fopen('row2.bin', 'w');
fwrite(file, c);
fclose(file);
file = fopen('row3.bin', 'w');
fwrite(file, d);
fclose(file);
%%