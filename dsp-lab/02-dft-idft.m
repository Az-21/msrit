% Experiment 2: DFT and IDFT

clc; clear; close all;

%% Matrix DFT and IDFT
xn = [1, 2, 3]; % Input signal

N = length(xn);
n = 0:N - 1;
k = 0:N - 1;
nk = n' * k;
Wk = exp(-2 * pi * nk * 1i / N); % Twiddle factor

% DFT
Xn = Wk * xn'; % Output signal
disp(Xn);

% IDFT
Xk = Wk * xn';
xn_idft = (1 / N) * conj(Wk) * Xk;
disp(xn_idft);

%% DFT using for loop
xn = [1, 2, 3, 4]; % Input signal
N = length(xn);

for k = 0:N - 1
    xk = 0;

    for n = 0:N - 1
        xk = xn(n + 1) * exp(-2 * pi * n * k * 1i / N) + xk;
    end

    Xk(k + 1, 1) = xk;
end

disp(Xk);

%% Linear and curcular convolution | NOTE: don't use built-in function in exam
xn = [1, 2, 3, 4];
hn = [1, -1, 1];

y_linear = conv(xn, hn);
y_circular = cconv(xn, hn, max(length(xn), length(hn)));

disp(y_linear);
disp(y_circular);

%% Equal linear and circular
xn = [1, 2, 3, 4];
hn = [1, -1, 1];

y_linear = conv(xn, hn);
y_circular = cconv(xn, hn, length(xn) + length(hn) - 1);

disp(y_linear);
disp(y_circular);
