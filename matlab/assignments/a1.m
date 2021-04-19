% Class #1 Assignment
% Saturday | April 17, 2021

%% Problem 1
clc; clear; close all;
x = [1, 2, 3, 4];
y = x * x; % [x] * T([x])
disp(y);

%% Problem 2
clc; clear; close all;
x = 1.000000001;
fx = uint64(round((log10(x) + exp(-x)) / (log(x))));
disp(fx);

%% Problem 3
clc; clear; close all;
p = [5, 6, 7];
a = p(1); b = p(2); c = p(3);
root1 = (-b + sqrt(b * b - 4 * a * c)) / (2 * a);
root2 = (-b - sqrt(b * b - 4 * a * c)) / (2 * a);
disp(root1);
disp(root2);

%% Problem 4
clc; clear; close all;
N = 4;
omega = 2 * pi / N;
n = 1:5;
z = exp(-1i * omega .* n) .* sin(omega .* n) + 4 .* cos(omega .* n) / 5;
disp(z);
