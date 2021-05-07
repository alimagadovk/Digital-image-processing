function [im_res] = Soft_Filt_w(im,l,lamb)
wav_im = ImDWT(im, l);


% figure
% imshow(uint8(wav_im))
% title('Вейвлет-преобразование')


i = size(im,1)/(2^l);
j = size(im,2)/(2^l);
lf_sub = wav_im(1:i,1:j);

mas1 = find(abs(wav_im(:)) <= lamb);
mas2 = find(abs(wav_im(:)) > lamb);
if (~(isempty(mas1) & isempty(mas2)))
    wav_im(mas1) = 0;
    wav_im(mas2) = sign(wav_im(mas2)).*(abs(wav_im(mas2)) - lamb);
    wav_im(1:i,1:j) = lf_sub;
%     figure
%     imshow(uint8(wav_im))
%     title('Обработанное вейвлет-преобразование')
    im_res = ImiDWT(wav_im, l);
    
else
    im_res = im;
end