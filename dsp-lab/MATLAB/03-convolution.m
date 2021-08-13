% Experiment 3: Convolution

clc; clear; close all;

% --------------- Convolution methods ---------------
%% Linear convolution
x_n = [1, 2, 3, 4];
h_n = [1, -1, 2];

% Zero padding
N = length(x_n) + length(h_n) - 1;
x_n = [x_n, zeros(1, N - length(x_n))];
h_n = [h_n, zeros(1, N - length(h_n))];

h_n = flip(h_n); % h(n) -> h(-n)
y_n = zeros(1, N); % init

% Slide multiplication. x(n) fixed, h(n) slides
for i = 1:N
    y_n(1, i) = x_n(1:i) * h_n(end - i + 1:end)';
end

% Output
disp(y_n);

%% Stockham Method
x_n = [1, 2, 3, 4];
h_n = [1, -1, 2];

% Zero padding
N = max(length(x_n), length(h_n));
x_n = [x_n, zeros(1, N - length(x_n))];
h_n = [h_n, zeros(1, N - length(h_n))];

% Twiddle factor
n = 0:N - 1;
k = 0:N - 1;
nk = n' * k;
W_n = exp(-2 * pi * nk * 1i / N);

% DFT
X_k = W_n * x_n';
H_k = W_n * h_n';

% DFT-IDFT Method
W_conj = (1 / N) * conj(W_n);
Y_k = X_k .* H_k;
y_n = (W_conj * Y_k)';

% Output
disp(y_n);

%% Matrix method
x_n = [1, 2, 3, 4];
h_n = [1, -1, 2];

% Zero padding
N = max(length(x_n), length(h_n));
x_n = [x_n, zeros(1, N - length(x_n))];
h_n = [h_n, zeros(1, N - length(h_n))];

% NxN matrix of x(n)
x_matrix = zeros(N, N);

for i = 1:N
    x_matrix(:, i) = x_n;
    x_n = [x_n(end), x_n(1:end - 1)]; % Circular shift
end

% Multiplication and output
y_n = x_matrix * h_n';
disp(y_n);

%% Graphical method
x_n = [1, 2, 3, 4];
h_n = [1, -1, 2];

M = length(x_n) + length(h_n) - 1; % equalizing length
x_n = [x_n, zeros(1, M - length(x_n))];
h_n = [h_n, zeros(1, M - length(h_n))];
y = zeros(1, M);

h_n = [h_n(1), flip(h_n(2:end))]; % first state

for i = 1:M
    temp = x_n .* h_n;
    y(1, i) = sum(temp);
    h_n = [h_n(end), h_n(1:end - 1)];
end

disp(y);

%% Tabular method
x = [2, 1, 0, 8];
h = [1, 9, 9, 5];

N = length(x);
M = length(h);

y_matrix = zeros(M, N + M - 1);

for i = 1:M
    temp = h(i) * x';
    leftPad = zeros(1, i - 1);
    rightPad = zeros(1, M - i);
    y_matrix(i, :) = [leftPad, temp', rightPad];
end

disp(sum(y_matrix));

%% Circular convolution | Needs clarification
x_n = [1, 3, 5, 7];
h_n = [2, 4];

% Zero padding
N = max(length(x_n), length(h_n));
x_n = [x_n, zeros(1, N - length(x_n))];
h_n = [h_n, zeros(1, N - length(h_n))];

for n = 1:N
    y_n = 0;

    for m = 1:N
        h_n(N + n + 1) = h_n(n);

        if (n - m) > 0
            y_n = x_n(m) * h_n(n - m) + y_n;
        else
            y_n = x_n(m) * h_n(n - m + N + 1) + y_n;
        end

    end

    temp(n, :) = y_n;
end

circularConv = temp(2:N);
disp(circularConv);

% --------------- Assignment ---------------
%% Question 1: Overlap add method
x_n = [1, 1, 0, 3, 1, 8, 0, 5, 0, 1, 1, 2, 2, 3];
h_n = [1, -1, 1];
disp(conv(x_n, h_n));

M = length(h_n);
N = 6;
L = N - M + 1;

% Pad zeros to make `length(x_n)` perfect multiple of `L`
remainder = rem(length(x_n), L);
x_n = [x_n, zeros(1, L - remainder)];

% Init x-matrix
rows = ceil(length(x_n) / N) + 1;
x_matrix = zeros(rows, N);

% Init column-rotated h-matrix (used in matrix convo)
h_n = [h_n, zeros(1, N - length(h_n))]; % To make `length(h_n) == N`
h_matrix = zeros(N, N);

for i = 1:N
    h_matrix(:, i) = h_n;
    h_n = [h_n(end), h_n(1:end - 1)];
end

% Init overlap add matrix
conv_matrix = zeros(rows, N + L * (rows - 1));

% Special `M - 1` overlap add method padding for each section
padding = zeros(1, M - 1);

for i = 1:rows
    x_matrix(i, :) = [x_n((i - 1) * L + 1:i * L), padding];

    % Convolution of each row with h_matrix. Save result with shift of `L`
    conv_matrix(i, 1 + L * (i - 1):N + L * (i - 1)) = h_matrix * x_matrix(i, :)';
end

% Final result using overlap add method (add columns)
y_n = zeros(1, N + L * (rows - 1));

for i = 1:rows
    y_n = y_n + conv_matrix(i, :);
end

disp(conv_matrix);
disp(y_n);

%% Question 2: Overlap save method
x_n = [1, 1, 0, 3, 1, 8, 0, 5, 0, 1, 1, 2, 2, 3];
h_n = [1, -1, 1];
disp(conv(x_n, h_n));

M = length(h_n);
N = 6;
L = N - M + 1;

% Pad zeros to make `length(x_n)` perfect multiple of `L`
remainder = rem(length(x_n), L);
x_n = [x_n, zeros(1, L - remainder)];

% Init x-matrix
rows = ceil(length(x_n) / N) + 1;
x_matrix = zeros(rows, N);

% Init column-rotated h-matrix (used in matrix convo)
h_n = [h_n, zeros(1, N - length(h_n))]; % To make `length(h_n) == N`
h_matrix = zeros(N, N);

for i = 1:N
    h_matrix(:, i) = h_n;
    h_n = [h_n(end), h_n(1:end - 1)];
end

% Formation of overlap save matrix
% First row which does not borrow from previous row
x_matrix(1, :) = [zeros(1, M - 1), x_n(1:L)]; % First row with `M-1` zeros prefixed

for i = 2:rows
    last = x_matrix(i - 1, end - M + 2:end); % last M-1 elements
    x_matrix(i, :) = [last, x_n((i - 1) * L + 1:i * L)];
end

% Matrix convolution of each row of x_matrix with h_matrix.
for i = 1:rows
    conv_matrix(i, :) = h_matrix * x_matrix(i, :)';
end

% Delete first `M-1` columns from convolution matrix
conv_matrix = conv_matrix(:, M:end);

% Flatten matrix
conv_matrix = conv_matrix'; % column-wise flat -> row-wise flat
disp(conv_matrix(:)');
