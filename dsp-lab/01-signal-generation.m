% Experiment 1: Signal Generation

clc; clear; close all;

% --------------- Unit Step ---------------
%% Unit step function
t = -5:0.01:5;
u = t >= 0;
plot(t, u);

%% Discrete unit step function
t = -5:1:5;
u = t >= 0;
stem(t, u);

%% u(-t)
t = -5:0.01:5;
u = t <= 0;
plot(t, u);

%% -u(t)
t = -5:0.01:5;
u = t >= 0;
plot(t, -u);

%% 2[u(t-1) - u(t-2)]
t = -5:0.01:5;
u = t >= 1 & t <= 2;
plot(t, 2 * u);

% --------------- Unit Ramp ---------------
%% Unit ramp function
t = -5:0.01:5;
u = t >= 0;
r = t .* u;
plot(t, r);

% --------------- Exponential ---------------
%% Exponential growth
t = -5:0.01:5;
u = t >= 0;
e = exp(t .* u);
plot(t, e);

%% Exponential decay
t = -5:0.01:5;
u = t >= 0;
e = exp(-t .* u);
plot(t, e);

% --------------- Sine Functions ---------------
%% sin(wt), t>=0
t = -5:0.01:5;
u = t >= 0;
f = 1;
s = sin(2 * pi * f * (t .* u));
plot(t, s);

%% cos(wt), t>=0
t = -5:0.01:5;
u = t >= 0;
f = 1;
c = cos(2 * pi * f * (t .* u));
plot(t, c);

% --------------- Complex Sine Functions ---------------
%% Growing complex sin | e^(t) * sin(wt)
t = -5:0.01:5;
u = t >= 0;
f = 1;
e = exp(t .* u);
s = sin(2 * pi * f * (t .* u));
csg = e .* s;
plot(t, csg);

%% Decaying complex sin | e^(-t) * sin(wt)
t = -5:0.01:5;
u = t >= 0;
f = 1;
e = exp(-t .* u);
s = sin(2 * pi * f * (t .* u));
csd = e .* s;
plot(t, csd);

% --------------- Signal Generation ---------------
%% u(t-1) + u(t-2) - 2u(t-3)
t = -5:0.01:5;
x1 = t >= 1 & t <= 3;
x2 = t >= 2 & t <= 3;
plot(t, x1 + x2);

%% Homework #1: Question 1
t = -5:0.01:5;
x1 = t >= 1 & t < 2;
x2 = t >= 2 & t <= 3;
r1 = x1 .* (t - 1);
r2 = -1 .* x2 .* (t - 3);
plot(t, r1 + r2);

%% Homework #1: Question 2
plot(t / 2 + 0.5, -2 * (r1 + r2)); % time scaling -> shift time by 0.5 to compensate -> amplitude scaling

% --------------- Rectifier ---------------
%% Half wave rectifier
x = -5:0.01:15;
region = x >= 0;
y = sin(x);
half = y >= 0;
plot(x, region .* (y .* half));

%% Full wave rectifier
x = -5:0.01:15;
region = x >= 0;
y = abs(sin(x));
plot(x, region .* y);

%% Chopper
x = -5:0.01:15;
region = x >= 0;
y = sin(x);
chop = y >= 0 & y <= 0.8;
plot(x, region .* (y .* chop));
