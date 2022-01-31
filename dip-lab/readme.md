### Display image
```matlab
original = imread('pic.extension');
imshow(original);
```

### Logical/BW image
```matlab
% Logical (default threshold)
bw = im2bw(original);

% Logical (90%)
bwThreshold90 = im2bw(original, 0.9);
```

### Grayscale image
```matlab
% Grayscale
gray = rgb2gray(original);
```

### Best way to load images
```matlab
original = imread('pic.extension');
original = im2double(rgb2gray(original));
```

### Histogram
```matlab
% Histogram
imhist(gray);
title('Histogram');

% Histogram sliding
graySlide = gray - 100;
imhist(graySlide);

% Histogram equalization
[eq, T] = histeq(gray);
imshow(eq); % Equalized image
imhist(eq); % Equalized histogram
```

### Arithmatic operations

> Math operations involving two or more images can only be done on same size image/matrix
```matlab
originalA = imresize(originalA, [100, 100]);
originalB = imresize(originalB, [100, 100]);
```

```matlab
% Addition operation
imAdd = originalA + originalB;
imshow(imAdd);

% Subtraction operation
imSubt = originalA - originalB;
imshow(imSubt);

% Multiplication operation
imMult = immultiply(originalA, originalB);
imshow(imMult);

% Division operation
imDiv = imdivide(originalA, originalB);
imshow(imDiv);

% Invert operation
imInvert = imcomplement(originalA)l
imshow(imInvert);
```

### Logical operations

> Logical operations involving two or more images can only be done on same size image/matrix

```matlab
originalA = imresize(im2bw(originalA), [100, 100]);
originalB = imresize(im2bw(originalB), [100, 100]);
```

```matlab
% AND operation
imAND = logicalA & logicalB;
imshow(imAND);

% OR operation
imOR = logicalA | logicalB;
imshow(imOR);

% XOR operation
imXOR = xor(logicalA, logicalB);
imshow(imXOR);

% NOT operation
imNOT = imcomplement(logicalA);
imshow(imNOT);
imshow(~logicalA); % ~ == ! in MATLAB
```

### Image enhancement
```matlab
% Optimal gray
midLevel = graythresh(original);
bw = im2bw(original, midLevel);
imshow(bw);

% Power law transform
c = 1; % contrast
gamma = 1.4;
S = c * (original .^ gamma);
imshow(S);

% Log transform
c = 1; % contrast
S = c * log10(original + 1);
imshow(S);

% Histogram shift
H = original + 50;
imshow(H);
```
### Counting objects
```matlab
% Threshold logical image
midLevel = graythresh(orig);
bw = im2bw(orig, midLevel);
imshow(bw);

% Counting objects (N4)
[~, countN4] = bwlabel(bw, 4);
disp(countN4);

% Counting objects (N8)
[~, countN8] = bwlabel(bw, 8);
disp(countN8);
```

### Distace from origin
```matlab
% Artificial image
img = zeros(4, 4);
img(3, 3) = 1;
disp(img);

% Distances
distEu = bwdist(img, "euclidean")
distCh = bwdist(img, "chessboard")
distCb = bwdist(img, "cityblock")
```

### Distorting image
```matlab
% Noise
salted = imnoise(original, 'salt & pepper', 0.05);
imshow(salted);

% Gaussian
gauss = imnoise(original, 'gaussian', 0, 0.01);
%                      mean deviation ^  ^ standard dvt
imshow(gauss);

% Speckle
spec = imnoise(original, 'speckle', 0.5);
imshow(spec);

% Periodic distortion
[height, width] = size(original);
[x, y] = meshgrid(1:width, 1:height);
pNoise = 15 * sin((2 * pi * x/12) + (2 * pi * y/12));
imshow(original + uint8(pNoise));
```

### Edge detection
```matlab
% Create 7x7 mask
mask = (1/49) * ones(7, 7);
avf = uint8(filter2(mask, g));
imshow(avf);

% Edge detection: gray - average -> unsharp masking
edges = g - avf;
imshow(imcomplement(edges));

% Highboost filtering
sharpened = g + edges;
imshow(sharpened);

% Laplace
mask = [
    [-1, -1, -1];
    [-1,  8, -1];
    [-1, -1, -1]];
edges = uint8(filter2(mask, g));
imshow(imcomplement(edges));

% Laplace sharpening
subplot(3, 4, 7);
sharpened = g - edges;
imshow(sharpened);
```
