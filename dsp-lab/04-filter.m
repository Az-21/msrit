clc; clear; close all;

%% Sampling theorem
f_max = 1;
t_max = 0:0.001:1;
y_max = 2 * sin(2 * pi * f_max * t_max);

f_sample = 10; % greater f_sample, smoother recovery
t_sample = 0:1 / f_sample:1;
y_sample = 2 * sin(2 * pi * f_max * t_sample);

subplot(2, 1, 1);
plot(t_max, y_max);
subplot(2, 1, 2);
plot(t_sample, y_sample, ':');
hold on;
stem(t_sample, y_sample);

%% Unit step as a function
x = -5:0.01:5;
y = unit_step(x - 1) - unit_step(x - 3);
plot(x, y);

function u = unit_step(x)
    u = x >= 0;
end

%% Integration
syms x;
disp(int(cos(x), x));
% function ^     ^ integrand `dx`

%% FIR filter
fp = [50, 80]; % passband frequency (Hz)
fs = [10, 120]; % stopband frequency (Hz)
sampling = 1000; % sampling frequency (Hz) | = 1 if already sampled
rs = 0.01; % stopband ripple

% If band filter is used, MATLAB will automatically create 1x2 matrix
wp = 2 * pi * fp / sampling;
ws = 2 * pi * fs / sampling;

% Type of window
As = -20 * log(rs); % stopband attenuation
t_width = abs(wp(1) - ws(1)); % transition width

if As <= 21
    disp('Rectangular window');
    N = ceil(4 * pi / t_width);

    if rem(N, 2) == 0
        N = N + 1;
    end

    wn = @(n)(1);

elseif As > 21 && As < 44
    disp('Hanning window');
    N = ceil(8 * pi / t_width);

    if rem(N, 2) == 0
        N = N + 1;
    end

    wn = @(n)(0.5 * (1 - cos(2 * pi * n / (N - 1))));

else
    disp('Hamming window');
    N = ceil(8 * pi / t_width);

    if rem(N, 2) == 0
        N = N + 1;
    end

    wn = @(n)(0.54 - 0.46 * cos(2 * pi * n / (N - 1)));

end

tao = (N - 1) / 2;

% Basic filter
hd = @(w, n)(1 / (2 * pi)) * exp(-w * tao * 1i) * exp(w * n * 1i);
hn = zeros(1, N);
syms w n z;

if length(fs) == 1 % Pass filters
    cutoff = (wp + ws) / 2; %wc

    if wp > ws
        disp('Highpass filter');

        for n = 0:N - 1
            hnd = double(int(hd(w, n), 'w', -pi, -cutoff) + int(hd(w, n), 'w', cutoff, pi));
            hn(n + 1) = hnd * wn(n);
        end

    else
        disp('Lowpass filter');
        syms w n z;

        for n = 0:N - 1
            hnd = double(int(hd(w, n), 'w', -cutoff, cutoff));
            hn(n + 1) = hnd * wn(n);
        end

    end

else % Band filters
    cutoff1 = (wp(1) + ws(1)) / 2;
    cutoff2 = (wp(2) + ws(2)) / 2;

    if wp(1) > ws(1)
        disp('Bandpass filter');

        for n = 0:N - 1
            hnd = double(int(hd(w, n), 'w', -cutoff2, -cutoff1) + int(hd(w, n), 'w', cutoff1, cutoff2));
            hn(n + 1) = hnd * wn(n);
        end

    else
        disp('Bandstop filter');

        for n = 0:N - 1
            hnd = double(int(hd(w, n), 'w', -pi, -cutoff2) + int(hd(w, n), 'w', -cutoff1, cutoff1) + int(hd(w, n), 'w', cutoff2, pi));
            hn(n + 1) = hnd * wn(n);
        end

    end

end

% Plot
m = 0:N - 1;
stem(m, hn);

%% Butterworth filter
wp = input('Enter the value of passband frequency in rad/sec : ')
ws = input('Enter the value of stopband frequency in rad/sec : ')
rp = input('Enter the value of passband ripple : ')
rs = input('Enter the value of stoband ripple : ')

[n, wn] = buttord(wp, ws, rp, rs, 's')

if length(wp) == 1

    if wp < ws
        disp('Lowpass filter')
        [b, a] = butter(n, wn, 'Low', 's')
        w = 0:1:(2 * max(wp, ws));
    else
        disp('Highpass filter')
        [b, a] = butter(n, wn, 'High', 's')
        w = 0:1:(2 * max(wp, ws));
    end

else

    if wp(1) > ws(1)
        disp('Bandpass filter')
        [b, a] = butter(n, wn, 'Pass', 's')
        w = 0:1:(2 * max(wp(1), ws(1)));
    else
        disp('Bandstop fiter')
        [b, a] = butter(n, wn, 'Stop', 's')
        w = 0:1:(2 * max(wp(1), ws(1)));
    end

end

h = freqs(b, a, w)
mag = 20 * log(abs(h))
plot(w, mag)
[z p k] = buttap(n)

%% Chebyshev filter
wp = input('Enter the value of passband frequency in rad/sec : ')
ws = input('Enter the value of stopband frequency in rad/sec : ')
rp = input('Enter the value of passband ripple : ')
rs = input('Enter the value of stoband ripple : ')
[n, wn] = cheb1ord(wp, ws, rp, rs, 's')

if length(wp) == 1

    if wp < ws
        disp('Low pass')
        [b, a] = cheb1(n, wn, 'Low', 's')
        w = 0:1:(2 * max(wp, ws));
    else
        disp('High pass')
        [b, a] = cheb1(n, wn, 'High', 's')
        w = 0:1:(2 * max(wp, ws));
    end

else

    if wp(1) > ws(1)
        disp('Bandpass filter')
        [b, a] = cheb1(n, wn, 'Pass', 's')
        w = 0:1:(2 * max(wp(1), ws(1)));
    else
        disp('Bandstop filter')
        [b, a] = cheb1(n, wn, 'Stop', 's')
        w = 0:1:(2 * max(wp(1), ws(1)));
    end

end

h = freqs(b, a, w)
mag = 20 * log(abs(h))
plot(w, mag)
[z p k] = cheb1ap(n)
