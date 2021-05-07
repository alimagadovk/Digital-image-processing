function I1 = adapt_filt(I, sigma_n2, m, n)

[M N] = size(I);
r1 = ones(1,N); r1(1) = (n - 1)/2 + 1; r1(end) = (n - 1)/2 + 1;
r2 = ones(1,M); r2(1) = (m - 1)/2 + 1; r2(end) = (m - 1)/2 + 1;
I_rep = repelem(repelem(I,1,r1)',1,r2)';
for i = 1:M
    for j = 1:N
        mL = 1/m/n*sum(sum(I_rep(i:i+m-1,j:j+n-1)));
        sigma_L2 = 1/(m*n - 1)*sum(sum((I_rep(i:i+m-1,j:j+n-1) - mL).^2));
        if (sigma_n2 <= sigma_L2)
            I1(i,j) = I(i,j) - sigma_n2/sigma_L2*(I(i,j) - mL);
        else
            I1(i,j) = mL;
        end
    end
end
end