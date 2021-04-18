% Class #2 Assignment
% Sunday | April 18, 2021

%% Problem 1. (i): find sol of system of linear eq
% --------------------------------------------------------------------------
clc; clear; close all;
A = [
    [5, 6, 7];
    [7, 0, 9];
    [2, 4, 0];
    ];
B = [2, 5, 3]';

x = A \ B; % Ax = B => x = inv(A) * B
disp(x);

% Problem 1. (ii): flatten the matrix
A = A(:)';
disp(A);

% Problem 1. (iii): Discrete plot of A assuming signal starts at t=0
% ! NOTE: HEX color requires MATLAB 2019+. remove fields with `#` to run on 2018 or older

t = 0:length(A) - 1;
stem(t, A, 'o', 'color', '#4AD162', 'MarkerFaceColor', '#4AD162');
title('Discrete plot of A');
xlabel('Time');
ylabel('A');
axis([-1, length(A), 0, max(A) + 2]);
grid('on');
set(gca, 'color', '#24292E');
set(gca, 'GridColor', '#a0a0a0');

%% Problem 2. (i): overlapped plots
% --------------------------------------------------------------------------
clc; clear; close all;

x = -5:0.01:5;
y1 = exp(-x);
y2 = exp(x) .* cos(x);
y3 = sin(x);
y4 = exp(-x) .* sin(x);

plot(x, y1, ...
    x, y2, ...
    x, y3, ...
    x, y4);
axis([-4, 4, -10, 10]);
title('Overlapping Plot');
xlabel('x');
ylabel('f(x)');
legend('e^{-x}', 'e^x \times cos(x)', 'sin(x)', 'e^{-x} \times sin(x)');
grid('on');
set(gca, 'color', '#24292E');
set(gca, 'GridColor', '#a0a0a0');

%% Problem 2 (ii): Subplots
% --------------------------------------------------------------------------
% Subplot of y1
subplot(2, 2, 1);
plot(x, y1, '.', 'color', '#E8235B');
legend('e^{-x}');
xlabel('x');
ylabel('y1');
grid('on');
set(gca, 'color', '#24292E');
set(gca, 'GridColor', '#a0a0a0');

% Subplot of y2
subplot(2, 2, 2);
plot(x, y2, '.', 'color', '#4AD162');
legend('e^x \times cos(x)');
xlabel('x');
ylabel('y2');
grid('on');
set(gca, 'color', '#24292E');
set(gca, 'GridColor', '#a0a0a0');

% Subplot of y3
subplot(2, 2, 3);
plot(x, y3, '.', 'color', '#0094EB');
legend('sin(x)');
xlabel('x');
ylabel('y3');
grid('on');
set(gca, 'color', '#24292E');
set(gca, 'GridColor', '#a0a0a0');

% Subplot of y3
subplot(2, 2, 4);
plot(x, y4, '.', 'color', '#F7E02E');
legend('e^{-x} \times sin(x)');
xlabel('x');
ylabel('y4');
grid('on');
set(gca, 'color', '#24292E');
set(gca, 'GridColor', '#a0a0a0');
