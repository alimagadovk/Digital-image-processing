function h = Gauss_filt(M,N,D0,x,y)
h = ones(M,N);
h1 = 1 - Gauss_peak(M,N,D0,x,y);
h2 = 1 - Gauss_peak(M,N,D0,-x,-y);
h = 1 - h .* h1 .* h2;
end