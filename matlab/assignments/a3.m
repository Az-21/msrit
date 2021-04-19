% Class #3 Assignment
% Monday | April 19, 2021

%% Problem 1
clc; clear; close all;

x = 1:7; % input sequence
col = 3; % new sequence length

n = length(x);
row = ceil(n / col);
sigma = zeros(1, col); % sum of columns
reX = zeros(row, col); % reshaped matrix

% Padding with zeros if required
if length(x) ~= row * col
    padding = zeros(1, row * col - n);
    x = [x padding]; % append zeros
end

% Summing columns and
for i = 1:row

    for j = 1:col
        element = x((i - 1) * col + j);
        sigma(j) = sigma(j) + element;
        reX(i, j) = element;
    end

end

disp(reX);
disp(sigma);

%% Problem 2
clc; clear; close all;

f = [2, 5, 1, 7];
sortAsc = f;
sortDes = f;

for i = 1:length(f)

    for j = 1:length(f) - 1

        if sortAsc(j) > sortAsc(j + 1)
            temp = sortAsc(j);
            sortAsc(j) = sortAsc(j + 1);
            sortAsc(j + 1) = temp;
        end

        if sortDes(j) < sortDes(j + 1)
            temp = sortDes(j + 1);
            sortDes(j + 1) = sortDes(j);
            sortDes(j) = temp;
        end

    end

end

disp(sortAsc);
disp(sortDes);
