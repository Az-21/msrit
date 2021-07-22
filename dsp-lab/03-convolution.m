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
