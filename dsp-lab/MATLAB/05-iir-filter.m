clc; clear; close all;

%% Butterworth filter
% wp = input('Enter the value of passband frequency in rad/sec : ')
% ws = input('Enter the value of stopband frequency in rad/sec : ')
% rp = input('Enter the value of passband ripple : ')
% rs = input('Enter the value of stoband ripple : ')
wp = 120;
ws = 240;
rp = 1;
rs = 1;
lwp = length(wp);
[n, wn] = buttord(wp, ws, rp, rs, 's');

if lwp == 1

    if wp < ws
        disp('Lowpass')
        [b, a] = butter(n, wn, 'low', 's');
        w = 0:1:(2max(wp, ws));
    else
        disp('Highpass')
        [b, a] = butter(n, wn, 'high', 's');
        w = 0:1:(2max(wp, ws));
    end

else

    if wp(1) < ws(1)
        disp('Bandstop')
        [b, a] = butter(n, wn, 'stop', 's');
        w = 0:1:(2max(wp(1), ws(1)));
    else
        disp('Bandpass')
        [b, a] = butter(n, wn, 'bandpass', 's');
        w = 0:1:(2max(wp(1), ws(1)));
    end

end

h = freqs(b, a, w);
mag = 20log(abs(h));
plot(w, mag);
[z, p, k] = buttap(n);
