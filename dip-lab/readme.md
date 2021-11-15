I'll organize these notes Soon™. Meanwhile, here's the full code dump.

### Todo
```matlab
clc; clear; close all;

% Load
original = imread('rice.jpg');
subplot(3, 3, 1);
imshow(original);
title('Original');

% Logical (default threshold)
bw = im2bw(original);
subplot(3, 3, 2);
imshow(bw);
title('Logical (Default Threshold)');

% Logical (90%)
bwThreshold90 = im2bw(original, 0.9);
subplot(3, 3, 3);
imshow(bwThreshold90);
title('Logical (90% Threshold)');

% Grayscale
gray = rgb2gray(original);
subplot(3, 3, 4);
imshow(gray);
title('Grayscale');

% Histogram
subplot(3, 3, 5);
imhist(gray);
title('Histogram');

% Histogram sliding
graySlide = gray - 100;
subplot(3, 3, 6);
imhist(graySlide);
title('Histogram (after sliding)');
subplot(3, 3, 7);
imshow(graySlide);
title('Grayscale (after sliding)');

% Histogram equalization
[eq, T] = histeq(gray);
subplot(3, 3, 8);
imshow(eq);
title('Equalized');
subplot(3, 3, 9);
imhist(eq);
title('Equalized Histogram');
```

### Todo
```matlab
clc; clear; close all;

% Load. Math operations  can only be done on same size image/matrix
originalA = imread('sahoobluesA.png');
originalA = imresize(originalA, [100, 100]);
subplot(3, 4, 1);
imshow(originalA);
title('Char A');

originalB = imread('sahoobluesS.png');
originalB = imresize(originalB, [100, 100]);
subplot(3, 4, 2);
imshow(originalB);
title('Char B');

% Addition operation
imAdd = originalA + originalB;
subplot(3, 4, 3);
imshow(imAdd);
title('Addition Operation');

% Subtraction operation
imSubt = originalA - originalB;
subplot(3, 4, 4);
imshow(imSubt);
title('Subtraction Operation');

% Multiplication operation
imMult = immultiply(originalA, originalB);
subplot(3, 4, 5);
imshow(imMult);
title('Multiplication Operation');

% Division operation
imDiv = imdivide(originalA, originalB);
subplot(3, 4, 6);
imshow(imDiv);
title('Division Operation');

% Logical conversion (B&W)
logicalA = im2bw(originalA);
subplot(3, 4, 7);
imshow(logicalA);
title('Logical Char A');

logicalB = im2bw(originalB);
subplot(3, 4, 8);
imshow(logicalB);
title('Logical Char B');

% AND operation
imAND = logicalA & logicalB;
subplot(3, 4, 9);
imshow(imAND);
title('AND Operation');

% OR operation
imOR = logicalA | logicalB;
subplot(3, 4, 10);
imshow(imOR);
title('OR Operation');

% XOR operation
imXOR = xor(logicalA, logicalB);
subplot(3, 4, 11);
imshow(imXOR);
title('XOR Operation');

% NOT operation
imNOT = imcomplement(logicalA);
% ~logicalA also works (only for logical)
% imcomplement = PixelValue.Max - PixelValue.Current
% If question says JPEG/uInt8, then PixelValue.Max = 255 even if it is <255
subplot(3, 4, 12);
imshow(imNOT);
title('NOT Operation');
```

### Todo
```matlab
clc; clear; close all;

original = imread('face.jpeg');
[height, width, colors] = size(original);
S = zeros(height, width, colors);
original = im2double(original);

% Original
subplot(2, 3, 1);
imshow(original);
title('Original');

% Optimal gray
subplot(2, 3, 2);
midLevel = graythresh(original);
bw = im2bw(original, midLevel);
imshow(bw);
title('Optimal BW')

% Gamma
gamma = 1.4;
C = 1;
for i = 1:height
    for j = 1:width
        for k = 1:colors
        S(i, j, k) = C * original(i, j, k) ^ gamma;
        end
    end
end
subplot(2, 3, 3);
imshow(S);
title(gamma);

% Gamma
gamma = 0.80;
C = 1;
for i = 1:height
    for j = 1:width
        for k = 1:colors
        S(i, j, k) = C * original(i, j, k) ^ gamma;
        end
    end
end
subplot(2, 3, 4);
imshow(S);
title(gamma);

% Gamma (log)
gamma = 0.95;
C = 1;
for i = 1:height
    for j = 1:width
        for k = 1:colors
        S(i, j, k) = C * log(original(i, j, k) + 1);
        end
    end
end
subplot(2, 3, 5);
imshow(S);
title('Log');

% Histogram shift
original = imread('face.jpeg');
subplot(2, 3, 6);
H = original + 50;
imshow(H);
title('Histogram shift');
```
### Todo
```matlab
clc; clear; close all;


% Original
orig = imread('rice.jpg');
subplot(4, 3, 1);
imshow(orig);
title('Original');

% Threshold grayscale
subplot(4, 3, 2);
midLevel = graythresh(orig);
bw = im2bw(orig, midLevel);
imshow(bw);
title('Midlevel threshold');

% Counting objects (N4)
[~, countN4] = bwlabel(bw, 4);
disp(countN4);

% Counting objects (N8)
[~, countN8] = bwlabel(bw, 8);
disp(countN8);

% ----- Distance from 1 -------
% Artificial image
img = zeros(4, 4);
img(3, 3) = 1;
disp(img);

% Distances
distEu = bwdist(img, "euclidean")
distCh = bwdist(img, "chessboard")
distCb = bwdist(img, "cityblock")

% Power law transform
% S = C * (R_max)^gamma
% S -> Max pixel after transform
% C and gamma -> constants for transform
% R_max -> Max pixel allowable before transform

R_max = 0: 10: 250;
C1 = 255 / 255^0.4;
C2 = 255 / 255^2.5;

S1 = C1 * R_max.^0.4;
S2 = C2 * R_max.^2.5;

subplot(2,1,1);
stem(R_max, S1);
subplot(2,1,2);
stem(R_max, S2);
```

### Todo
```matlab
clc; clear; close all;

% Original
subplot(3, 3, 1);
original = imread('laptopScreen.jpeg');
imshow(original);

% Gray
subplot(3, 3, 2);
original = rgb2gray(original);
imshow(original);

% Noise
subplot(3, 3, 3);
salted = imnoise(original, 'salt & pepper', 0.05);
imshow(salted);

% Gaussian
subplot(3, 3, 4);
gauss = imnoise(original, 'gaussian', 0, 0.01);
%                      mean deviation ^  ^ standard dvt
imshow(gauss);

% Speckle
subplot(3, 3, 5);
spec = imnoise(original, 'speckle', 0.5);
imshow(spec);

% Periodic distortion
subplot(3, 3, 6);
[height, width] = size(original);
[x, y] = meshgrid(1:width, 1:height);
pNoise = 15 * sin(2*pi*x/12 + 2*pi*y/12);
imshow(original + uint8(pNoise));
```