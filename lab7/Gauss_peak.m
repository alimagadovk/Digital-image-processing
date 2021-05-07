function Z = Gauss_peak(M,N,D0,x,y)
if nargin == 3
    x = 0;
    y = 0;
end
D = @(u,v)sqrt((u - M/2 - 1 - x).^2 + (v - N/2 - 1 - y).^2);
H = @(u,v) exp((-D(u,v).^2)./(2*(D0^2)));
X = 1:M;
Y = 1:N;
[X,Y] = meshgrid(X,Y);
Z = H(X,Y);
end