%% task1
clc
clear
close all

C = 1.5;

Nx = 30;
mx1 = 10;
mx2 = 20;
sigmax1 = 2*C;
sigmax2 = 5*C;
x(1,1:Nx) = mx1 + sigmax1.*rand(1,Nx);
x(2,1:Nx) = mx2 + sigmax2.*rand(1,Nx);


Ny = 40;
my1 = 40;
my2 = 10;
sigmay1 = 10*C;
sigmay2 = 2*C;
y(1,1:Ny) = my1 + sigmay1.*rand(1,Ny);
y(2,1:Ny) = my2 + sigmay2.*rand(1,Ny);

v1 = [mx1, mx2]' - [my1, my2]';
v2 = [mx1, mx2]' + [my1, my2]';

f = @(p)(0.5*v1'*v2 - v1(1)*p)/v1(2);
vp = [22 30];

figure
hold on
grid on
plot(x(1,:),x(2,:),'*r')
plot(y(1,:),y(2,:),'ob')
plot(vp,f(vp),'r','LineWidth',3)
%% task2
clc
clear
close all

C = 1.5;

Nx = 30;
mx1 = 10;
mx2 = 20;
sigmax1 = 2*C;
sigmax2 = 5*C;
x(1,1:Nx) = mx1 + sigmax1.*rand(1,Nx);
x(2,1:Nx) = mx2 + sigmax2.*rand(1,Nx);


Ny = 40;
my1 = 40;
my2 = 10;
sigmay1 = 10*C;
sigmay2 = 2*C;
y(1,1:Ny) = my1 + sigmay1.*rand(1,Ny);
y(2,1:Ny) = my2 + sigmay2.*rand(1,Ny);

Nz = 20;
mz1 = 50;
mz2 = 25;
sigmaz1 = 7;
sigmaz2 = 4;
z(1,1:Nz) = mz1 + sigmaz1.*rand(1,Nz);
z(2,1:Nz) = mz2 + sigmaz2.*rand(1,Nz);

v1 = [mx1, mx2]' - [my1, my2]';
v2 = [mx1, mx2]' + [my1, my2]';
f1 = @(p)(0.5*v1'*v2 - v1(1)*p)/v1(2);

v1 = [mx1, mx2]' - [mz1, mz2]';
v2 = [mx1, mx2]' + [mz1, mz2]';
f2 = @(p)(0.5*v1'*v2 - v1(1)*p)/v1(2);

v1 = [my1, my2]' - [mz1, mz2]';
v2 = [my1, my2]' + [mz1, mz2]';
f3 = @(p)(0.5*v1'*v2 - v1(1)*p)/v1(2);

vp1 = [20 40];
vp2 = [25 35];
vp3 = [25 60];

figure
hold on
grid on
plot(x(1,:),x(2,:),'*r')
plot(y(1,:),y(2,:),'ob')
plot(z(1,:),z(2,:),'.g')
plot(vp1,f1(vp1),'r','LineWidth',3)
plot(vp2,f2(vp2),'b','LineWidth',3)
plot(vp3,f3(vp3),'g','LineWidth',3)
%% task3
clc
clear
close all

im = rgb2gray(imread('im.png'));
prim = rgb2gray(imread('star.png'));
im = 255 - double(im);
prim = 255 - double(prim);
im_n = im + 350*randn(size(im));


figure
imshow(uint8(im))
title('Исходное изображение')

figure
imshow(uint8(prim))
title('Эталон')

figure
imshow(uint8(im_n))
title('Зашумлённое изображение')

%imwrite(uint8(im_n),'task3_im_n_300.png','png');

[M,N] = size(im);
H = zeros(M,N);
H(1:size(prim,1),1:size(prim,2)) = prim;

r = ifft2(fft2(im_n).*conj(fft2(H)));


[X, Y] = meshgrid(1:M,1:N);

figure
hold on
grid on
mesh(r)
plot3(X(r == max(r(:))),Y(r == max(r(:))),r(r == max(r(:))), 'r*')