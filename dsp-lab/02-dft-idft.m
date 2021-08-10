% Experiment 2: DFT and IDFT

clc; clear; close all;

% --------------- DFT and IDFT Methods ---------------
%% Matrix DFT
x_n = [1, 2, 3]; % Input signal

N = length(x_n);
n = 0:N - 1;
k = 0:N - 1;
nk = n' * k;
Wk = exp(-2 * pi * nk * 1i / N); % Twiddle factor

% DFT
Xn = Wk * x_n'; % Output signal
disp(Xn);

% Matrix IDFT
X_k = Wk * x_n';
xn_idft = (1 / N) * conj(Wk) * X_k;
disp(xn_idft);

%% DFT using for loop
x_n = [1, 2, 3, 4]; % Input signal
N = length(x_n);
X_k = zeros(N, 1);

for k = 0:N - 1

    for n = 0:N - 1
        X_k(k + 1, 1) = X_k(k + 1, 1) + x_n(n + 1) * exp(-2 * pi * n * k * 1i / N);
    end

end

disp(X_k);

%% Linear and curcular convolution
x_n = [1, 2, 3, 4];
h_n = [1, -1, 1];

y_linear = conv(x_n, h_n);
y_circular = cconv(x_n, h_n, max(length(x_n), length(h_n)));

disp(y_linear);
disp(y_circular);

%% Equal linear and circular
x_n = [1, 2, 3, 4];
h_n = [1, -1, 1];

y_linear = conv(x_n, h_n);
y_circular = cconv(x_n, h_n, length(x_n) + length(h_n) - 1);

disp(y_linear);
disp(y_circular);

% --------------- Assignment ---------------
%% Question 1: DFT of Birthday with mag and phase plot
x_n = [0, 4, 0, 6]; % Input signal
N = length(x_n);
X_k = zeros(1, N);

for k = 0:N - 1
    x_k = 0;

    for n = 0:N - 1
        x_k = x_n(n + 1) * exp(-2 * pi * n * k * 1i / N) + x_k;
    end

    X_k(1, k + 1) = x_k;
end

disp(X_k');

stem(0:N - 1, magnitude(X_k));
hold on;
stem(0:N - 1, radian_angle(X_k));
xlabel('Point');
ylabel('Intensity');
legend('Magnitude', 'Phasor (radians)');
grid('on');
set(gca, 'color', '#24292E');
set(gca, 'GridColor', '#a0a0a0');
axis([-1, N, -5, 15]);

function y = magnitude(complex)
    y = power((real(complex).^2 + imag(complex).^2), 1/2);
end

function y = radian_angle(complex)
    y = atan(imag(complex) ./ real(complex));
end
