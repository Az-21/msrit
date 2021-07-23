% Experiment 3: Convolution

clc; clear; close all;

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
x_n = [x_n zeros(1, M - length(x_n))];
h_n = [h_n zeros(1, M - length(h_n))];
y = zeros(1, M);

for n = 1:M

    for k = 1:n
        y(n) = y(n) + x_n(k) * h_n(n - k + 1);
    end

end

disp(y);

%% Homework #3: Tabular method
x_n = 1:10;
h_n = 6:8;

shift = 0;
lenX = length(x_n);
lenH = length(h_n);
y_n = zeros(1, lenX + lenH - 1); % tabular convolution init

for i = 1:lenH
    row = tabularShift(x_n, lenX, lenH, shift);
    y_n = y_n + h_n(i) .* row; % add columns
    shift = shift + 1;
end

disp(y_n);

function y_n = tabularShift(x_n, lenX, lenH, shift)
    y_n = zeros(1, lenX + lenH - 1);
    lenY = length(y_n);
    padding = zeros(1, lenY - lenX - shift);
    y_n(shift + 1:end) = [x_n(1:end), padding];
end

%% Circular convolution
x_n = [1, 3, 5, 7];
h_n = [2, 4];

% Zero padding
N = max(length(x_n), length(h_n));
x_n = [x_n, zeros(1, N - length(x_n))];
h_n = [h_n, zeros(1, N - length(h_n))];

for n = 1:N
    y_n = 0;

    for m = 1:N
        h_n(N + n +1) = h_n(n);

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

%% Tabular method [! Incorrect]
x_n = [1, 3, 5, 7];
h_n = [2, 4];

% Zero padding
N = max(length(x_n), length(h_n));
x_n = [x_n, zeros(1, N - length(x_n))];
h_n = [h_n, zeros(1, N - length(h_n))];

% retain first element, flip remaining elements
h_nr = [h_n(1), h_n(end:-1:2)];

% NxN matrix of x(n)
x_matrix = zeros(N, N);

for i = 1:N
    x_matrix(:, i) = x_n;
    x_n = [x_n(end), x_n(1:end - 1)]; % Circular shift
end

% temp
disp(x_matrix);
disp(h_n);

% Multiplication and output
y_n = x_matrix * h_n';
disp(y_n);

%% Overlap add method
x_n = [1, 1, 0, 3, 1, 8, 0, 5, 0, 1, 1, 2, 2, 3];
h_n = [1, -1, 1];

N = 6;
M = length(h_n);
L = N - M + 1; % N = L + M - 1

% Pad zeros to make `length(x_n)` perfect multiple of `L`
remainder = rem(length(x_n), L);
padding = zeros(1, L - remainder);
x_n = [x_n, padding];

% Init matrix
rows = ceil(length(x_n) / N) + 1;
x_matrix = zeros(rows, N); % init

% Special overlap add method padding for each section
padding = zeros(1, M - 1);

for i = 1:L
    x_matrix(i, :) = [x_n((i - 1) * L + 1:i * L), padding];
end

disp(x_matrix);

%% Overlap save method
x_n = [1, 1, 0, 3, 1, 8, 0, 5, 0, 1, 1, 2, 2, 3];
h_n = [1, -1, 1];

N = 6;
M = length(h_n);
L = N - M + 1; % N = L + M - 1

% Pad zeros to make `length(x_n)` perfect multiple of `L`
remainder = rem(length(x_n), L);
padding = zeros(1, L - remainder);
x_n = [x_n, padding];

% Init matrix
rows = ceil(length(x_n) / N) + 1;
x_matrix = zeros(rows, N);

% First row with `M-1` zeros prefixed
x_matrix(1, :) = [zeros(1, M - 1), x_n(1:L)];

for i = 2:L
    last = x_matrix(i - 1, end - M + 2:end); % last M-1 elements
    x_matrix(i, :) = [last, x_n((i - 1) * L + 1:i * L)];
end

disp(x_matrix);
