# MATLAB Cheatsheet

## Basic Setup

```matlab
% Clear command window and workspace
clc; clear; close all;

%% <- This creates a code section
% Section 1

%% <- This creates code section
% Section 2
```

## Complex Numbers

```matlab
% Complex declaration
num = 3 + 4j; % a + bj
disp(num);

% Conjugate
disp(conj(num)); % 3 - 4j

% Magnitude
disp(abs(num)); % 5.00
```

## Array/List

```matlab
% Array/List declaration
list = [100, 10, 1];
rangeList = 1:5; % [1, 2, 3, 4, 5];

% Some useful list methods
disp(max(list)); % 100
disp(min(list)); % 1
disp(sort(list)); % [1, 10, 100]
disp(length(list)); % 3

% List multiplication
a = [1, 3, 6, 9];
b = [2, 4, 6, 8];
disp(times(a, b)); % [2, 12, 36, 72]
disp(a .* b); % alternative
disp(a * b'); % another alternative. b' -> transpose

% Map operations on array
disp(a .* 2); % mult every element by 2
disp(a ./ 2); % div every element by 2
disp(a .^ 2); % raise every element by pow(2)
disp(a + 2); % add 2 to every element
disp(a - 2); % sub 2 with every element
```

## Problems

```matlab
% 1. Convert given expression into MATLAB expression
a = 5;
x = 2;
y = 8;

c = exp(-1 * a * x) * sin(x) + 50 * y^(1/3);
disp(c); % 100.0
```
