function res = My_filt(im_n,M,L)
d2 = zeros(size(im_n));
d4 = zeros(size(im_n));
d6 = zeros(size(im_n));
d8 = zeros(size(im_n));

d2(2:end,:) = im_n(1:end - 1,:) - im_n(2:end,:);
d4(:,2:end) = im_n(:,1:end - 1) - im_n(:,2:end);
d6(:,1:end - 1) = im_n(:,2:end) - im_n(:,1:end - 1);
d8(1:end - 1,:) = im_n(2:end,:) - im_n(1:end - 1,:);


mu_p_d = @(d)max( min(1,(d + M)./(L + M - 1)),0 );
mu_m_d = @(d)max( min(1,(-d + M)./(L + M - 1)),0);
mu_p_v = @(v)max( min(1,v./(1.5*L)), 0);
mu_m_v = @(v)max( min(1,v./(-1.5*L)), 0);



Q1 = @(d2, d4, d6, d8, v) min(min(min(min(mu_p_d(d2),mu_p_d(d4)),mu_p_d(d6)),mu_p_d(d8)), mu_p_v(v));
Q2 = @(d2, d4, d6, d8, v) min(min(min(min(mu_m_d(d2),mu_m_d(d4)),mu_m_d(d6)),mu_m_d(d8)), mu_m_v(v));
Q = @(d2, d4, d6, d8, v) max(Q1(d2, d4, d6, d8, v), Q2(d2, d4, d6, d8, v));


vw = (-1.5*L):(1.5*L);


s1 = zeros(size(im_n));
s2 = zeros(size(im_n));
for k = 1:length(vw)
    s1 = s1 + Q(d2,d4,d6,d8,vw(k))*vw(k);
    s2 = s2 + Q(d2,d4,d6,d8,vw(k));
end

res = s1./s2;
res(isnan(res)) = 0;

res = res + im_n;
    
end