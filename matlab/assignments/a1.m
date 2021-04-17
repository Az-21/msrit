% Class #1 Assignment
% Saturday | April 17, 2021

clc; clear; close all;

%% Problem 1
x = [1, 2, 3, 4];
y = x * x'; % [x] * T([x])
disp(y);

%% Problem 2
x = 1.000000001;
fx = uint64(round((log10(x) + exp(-x)) / (log(x))));
disp(fx);

%% Problem 3
polynomial = [5, 6, 7];
root = roots(polynomial);
disp(root);

%% Problem 4
N = 4;
omega = 2 * pi / N;
n = 1:5;
z = ones(1, length(n));

for i = 1:length(n)
    z(i) = exp(-1i * omega * i) * sin(omega * i) + 4 * cos(omega * i) / 5;
    disp(z(i));
end
