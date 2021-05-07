function res = My_filt2(im_n,M,L)
d2 = zeros(size(im_n));
d4 = zeros(size(im_n));
d6 = zeros(size(im_n));
d8 = zeros(size(im_n));

d2(2:end,:) = im_n(1:end - 1,:) - im_n(2:end,:);
d4(:,2:end) = im_n(:,1:end - 1) - im_n(:,2:end);
d6(:,1:end - 1) = im_n(:,2:end) - im_n(:,1:end - 1);
d8(1:end - 1,:) = im_n(2:end,:) - im_n(1:end - 1,:);

d = (d2 + d4 + d6 + d8)/4;


mu_p_d = @(d)max( min(1,(d + M)./(L + M - 1)),0 );
mu_m_d = @(d)max( min(1,(-d + M)./(L + M - 1)),0);
mu_p_v = @(v)max( min(1,v./(1.5*L)), 0);
mu_m_v = @(v)max( min(1,v./(-1.5*L)), 0);



Q1 = @(d, v) min(mu_p_d(d), mu_p_v(v));
Q2 = @(d, v) min(mu_m_d(d), mu_m_v(v));
Q = @(d, v) max(Q1(d, v), Q2(d, v));

vw = (-1.5*L):(1.5*L);


s1 = zeros(size(im_n));
s2 = zeros(size(im_n));

for k = 1:length(vw)
    s1 = s1 + Q(d,vw(k))*vw(k);
    s2 = s2 + Q(d,vw(k));
end
res = s1./s2;
res(isnan(res)) = 0;

res = res + im_n;
    
end