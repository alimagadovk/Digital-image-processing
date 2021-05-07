function [r, R, S] = MyGarmNoise(M, N, C, A, B)
K = size(C,1);
if nargin == 3
    A(1:K) = 1.0;
    B(1:K, 1:2) = 0;
elseif nargin == 4
    B(1:K, 1:2) = 0;
end 
r = zeros(M, N);
X = 1:M;
Y = 1:N;
[X,Y] = meshgrid(X,Y);
GarmNoise = @(x,y,A,w1,w2,phi_x,phi_y)A * cos((2*pi).*(w1.*x - phi_x)./M + (2*pi).*(w2.*y - phi_y)./N);
for j = 1:K
    r = r + GarmNoise(X,Y,A(j),C(j,1),C(j,2),B(j,1),B(j,2));
end
R = fftshift(fft2(r));
S = abs(R);
end