function im_res = Opt_filtr(im_n,noise,step)
im_res = zeros(size(im_n));
for i = 0:step:size(im_n,1) - step
    for j = 0:step:size(im_n,2) - step
        i1 = i + 1;
        i2 = i + step;
        j1 = j + 1;
        j2 = j + step;
        im_window = double(im_n(i1:i2,j1:j2));
        n_window = double(noise(i1:i2,j1:j2));
        gn_mean = mean(mean(im_window.*n_window));
        g_mean = mean(mean(im_window));
        n_mean = mean(mean(n_window));
        nn_mean = mean(mean(n_window.*n_window));
        w = (gn_mean - g_mean.*n_mean)./(nn_mean - n_mean.^2);
        im_window = im_window - w.*n_window;
        im_res(i1:i2,j1:j2) = im_res(i1:i2,j1:j2) + im_window;
    end
end
end