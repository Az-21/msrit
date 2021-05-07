% Batch 2 - Group 4
clc; clear; close all;

%% Problem 1 - Discrete Fuction Generation
x = 0:15; % Range of output
y = x.^2; % Function

disp('Problem 1 Function Data')
disp(x);
disp(y);

%% Problem 2 - Discrete Fuction Plot
stem(x, y);
grid('on');
xlabel('0 \leq x \leq 15');
ylabel('y=x^2 Step Function');
legend('y=x^2');
title('Problem 2: Discrete Plot');

%% Problem 3 - Submatrix Manipulation
matrix = [
    1:4;
    5:8;
    [9, 1:3];
    4:7;
    ];

disp('Problem 3 Submatrix Manipulation')
disp('Original Matrix');
disp(matrix);

A = matrix(3:4, 1:2);
invA = A^(-1);
matrix(3:4, 1:2) = invA;

disp('Modified Matrix')
disp(matrix);

%% Problem 4 - Special sum list
x = [1, 3, 4, 6, 7, 8];
y = zeros(1, length(x));
y(1) = x(1);

for i = 2:length(x)
    y(i) = x(i) + x(i - 1);
end

disp('Problem 4: Special Sum List')
disp('Original List')
disp(x);

disp('Modified List')
disp(y);
