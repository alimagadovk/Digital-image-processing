function [im_res] = Hard_Filt_w(im,l,lamb)
wav_im = ImDWT(im, l);



% figure
% imshow(uint8(wav_im))
% title('Вейвлет-преобразование')
% figure
% imshow(uint8(wav_im(i1:i2,j1:j2)))
% title('Низкочастотный саббэнд')


i = size(im,1)/(2^l);
j = size(im,2)/(2^l);
lf_sub = wav_im(1:i,1:j);
mas = find(abs(wav_im(:)) <= lamb);
if (~isempty(mas))
    wav_im(mas) = 0;
    wav_im(1:i,1:j) = lf_sub;
%     figure
%     imshow(uint8(wav_im))
%     title('Обработанное вейвлет-преобразование')
    im_res = ImiDWT(wav_im, l);
    
else
    im_res = im;
end