clc; clear; close all;

% input
x = [1:8 2:9]; % input sequence
col = 4; % new sequence length
shift = 2; % shift length

n = length(x);
row = ceil(n / col);
% Padding initial sequence with zeros if required
if length(x) ~= row * col
    padding = zeros(1, row * col - n);
    x = [x padding]; % append zeros
    disp(x);
end

% init
sigma = zeros(1, (row - 1) * shift + col); % sum of shifted rows
reX = zeros(row, (row - 1) * shift + col); % reshaped matrix

% create matrix row-by-row
for i = 1:row
    pl = (i - 1) * shift; % left padding
    pr = (row - 1) * shift - pl; % right padding

    %      | left pad  | |new sequence length slice | | right pad |
    temp = [zeros(1, pl) x((i - 1) * col + 1:i * col) zeros(1, pr)];

    reX(i, :) = temp;
    sigma = sigma + temp;
end

% output
disp(reX);
disp(sigma);
