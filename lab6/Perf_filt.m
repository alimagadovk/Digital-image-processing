function Z = Perf_filt(M,N,D0)
if nargin == 3
    x = 0;
    y = 0;
end
Z = zeros(M,N);
X = 1:M;
Y = 1:N;
[X,Y] = meshgrid(X,Y);
i = find(sqrt((X - M/2).^2 + (Y - N/2).^2) < D0);
Z(i) = 1;
end