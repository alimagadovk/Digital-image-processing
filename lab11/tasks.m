% task 1
clc
clear
close all
I = imread('rice.png');

figure
imshow(I)



T = 0;
T0 = 200/255;
dT = 1/255;

BW = imbinarize(I,T0);

J1 = I(BW == 1);
J2 = I(BW == 0);
while (abs(T - T0) >= dT)
    T0 = T;
    T = (mean(J1) + mean(J2))/(2*256);
    BW = imbinarize(I,T);
    J1 = I(BW == 1);
    J2 = I(BW == 0);
end


figure
level = graythresh(I);
BW2 = imbinarize(I,level);
%
N = 3;
sigma = 10;
J = imfilter(I, fspecial('gaussian',N,sigma), 'symmetric');
level = graythresh(J);
BW3 = imbinarize(J,level);

V(:,:,1,1) = BW;
V(:,:,1,2) = BW2;
V(:,:,1,3) = BW3;
montage(V,'Size', [1 3])
%imwrite(I,'rice.png','png')
%imwrite(BW,'task1_my_segmentation.png','png')
%imwrite(BW2,'task1_segmentation.png','png')
%imwrite(BW3,'task1_filt&segmentation.png','png')
%% task 2
clc
clear
close all
I = imread('task2_im.png');

figure
imshow(I)

threshold1 = 0.08;
BW1 = edge(I,'Sobel',threshold1);

figure
imshow(BW1)

threshold2 = 0.022;
sigma2 = 1.4;
BW2 = edge(I,'log',threshold2,sigma2);

figure
imshow(BW2)

threshold3 = 0.16;
BW3 = edge(I,'canny',threshold3);

figure
imshow(BW3)

%imwrite(BW1,'task2_gradient.png','png')
%imwrite(BW2,'task2_Marr_Hild.png','png')
%imwrite(BW3,'task2_Canny.png','png')
%% task 3
clc
clear
close all
RGB  = imread('MIET2.png');
I  = rgb2gray(RGB);
figure
imshow(I)

T = [0.2 0.45];
BW = edge(I,'canny', T);
%figure
%imshow(BW)
%
[H,T,R] = hough(BW);
figure
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

P  = houghpeaks(H,100,'threshold',ceil(0.4*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');

lines = houghlines(BW,T,R,P,'FillGap',20,'MinLength',15);
figure, R = imshow(I), hold on
max_len = 0;

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',3,'Color','blue');
end

%imwrite(I,'task3_im.png','png')
%% task 4
clc
clear
close all
RGB  = imread('MIET2.png');
I  = rgb2gray(RGB);

[L,N] = superpixels(RGB,50);

outputImage1 = zeros(size(RGB),'like',RGB);
idx = label2idx(L);
numRows = size(RGB,1);
numCols = size(RGB,2);
for labelVal = 1:N
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    outputImage1(redIdx) = mean(RGB(redIdx));
    outputImage1(greenIdx) = mean(RGB(greenIdx));
    outputImage1(blueIdx) = mean(RGB(blueIdx));
end    

figure
imshow(outputImage1)


[L,N] = superpixels(RGB,500);

outputImage2 = zeros(size(RGB),'like',RGB);
idx = label2idx(L);
numRows = size(RGB,1);
numCols = size(RGB,2);
for labelVal = 1:N
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    outputImage2(redIdx) = mean(RGB(redIdx));
    outputImage2(greenIdx) = mean(RGB(greenIdx));
    outputImage2(blueIdx) = mean(RGB(blueIdx));
end    

figure
imshow(outputImage2)


[L,N] = superpixels(RGB,2500);

outputImage3 = zeros(size(RGB),'like',RGB);
idx = label2idx(L);
numRows = size(RGB,1);
numCols = size(RGB,2);
for labelVal = 1:N
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    outputImage3(redIdx) = mean(RGB(redIdx));
    outputImage3(greenIdx) = mean(RGB(greenIdx));
    outputImage3(blueIdx) = mean(RGB(blueIdx));
end    

figure
imshow(outputImage3)
%
RGB = I;

[L,N] = superpixels(RGB,50);

outputImage4 = zeros(size(RGB),'like',RGB);
idx = label2idx(L);
for labelVal = 1:N
    redIdx = idx{labelVal};
    outputImage4(redIdx) = mean(RGB(redIdx));
end    

figure
imshow(outputImage4)


[L,N] = superpixels(RGB,500);

outputImage5 = zeros(size(RGB),'like',RGB);
idx = label2idx(L);
for labelVal = 1:N
    redIdx = idx{labelVal};
    outputImage5(redIdx) = mean(RGB(redIdx));
end  

figure
imshow(outputImage5)


[L,N] = superpixels(RGB,2500);

outputImage6 = zeros(size(RGB),'like',RGB);
idx = label2idx(L);
for labelVal = 1:N
    redIdx = idx{labelVal};
    outputImage6(redIdx) = mean(RGB(redIdx));
end

figure
imshow(outputImage6)

%imwrite(outputImage1,'task4_rgb_50.png','png')
%imwrite(outputImage2,'task4_rgb_500.png','png')
%imwrite(outputImage3,'task4_rgb_2500.png','png')
%imwrite(outputImage4,'task4_bw_50.png','png')
%imwrite(outputImage5,'task4_bw_500.png','png')
%imwrite(outputImage6,'task4_bw_2500.png','png')
%% task 5

clc
clear
close all

% d1=10; d2=8;
d1=10; d2=8;
Im = imread('MIET2.png');
Im = rgb2gray(Im);
H = fspecial('disk',d1);
blurred = imfilter(Im,H,'replicate');
blur = double(blurred);
h = fspecial('sobel');
g = sqrt(imfilter(blur,h,'replicate').^2 + imfilter(blur,h','replicate').^2);
g2 = imclose(imopen(g,strel('disk',d2)),strel('disk',d2));

L = watershed(g2);
wr = L==0;
f=Im;
f(wr)=255;

figure
imshow(Im);
figure
imshow(f);

%imwrite(f,'task5_not_best_res2.png','png')