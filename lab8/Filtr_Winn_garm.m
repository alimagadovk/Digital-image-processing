function im_res = Filtr_Winn_garm(im_n,R)
spectr = fftshift(fft2(im_n));
Sg = spectr .* conj(spectr);
Sf = Sg - R.*conj(R);
for k = 1:size(Sf,1)
    mas = find(Sf(k,:) < 0);
    for l = 1:length(mas)
        Sf(k,mas(l)) = 0;
    end
end
Filt_winn = Sf ./ Sg;
Filt_winn(size(spectr,1)/2 + 1,size(spectr,2)/2 + 1) = 1;
spectr = Filt_winn .* spectr;
im_res = ifft2(ifftshift(spectr));
end