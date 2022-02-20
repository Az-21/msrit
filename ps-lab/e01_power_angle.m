clc; clear; close all;

% ---------------------------------------------------------------------------- %
%                                 Salient Pole                                 %
% ---------------------------------------------------------------------------- %

% Parameters
Ra = 0;
Xd = 1;
Xq = 0.6;
V = 1;
pf = 1;
E = 1.1;
delta = 0:1:180;

% Power
E = abs(E);
V = abs(V);

P_m1 = E * V * sin(delta .* pi / 180) / Xd;
P_m2 = V * V * (Xd - Xq) * sin(2 * delta .* pi / 180) / (2 * Xd * Xq);

% Plot
plot(delta, P_m1); % real
hold on;
plot(delta, P_m2); % reluctance
hold on;
plot(delta, P_m1 + P_m2); % total

% Plot styling
grid on;
title('Power Angle Characteristics of Salient Pole Sync Machine');
xlabel('\delta (degree)');
ylabel('Power (p.u.)');
legend('P_{m1}: Real Power', 'P_{m2}: Reluctance Power', 'P_T   : Total Power');

% ---------------------------------------------------------------------------- %
%                               Non-Salient Pole                               %
% ---------------------------------------------------------------------------- %

% Parameters
Ra = 0;
Xs = 0.3;
V = 1;
pf = 0.8;
delta = 0:1:180;
P = 0.5;

% Calculating |E|
I = P / (V * pf);
phi = acos(pf);
Ia = I * cos(phi) - 1j * I * sin(phi);

Z = Ra + 1j * Xs;
E = V + Ia * Z;

% Power
E = abs(E);
V = abs(V);

P = E * V * sin(delta .* pi / 180) / Xs;

% Plot
plot(delta, P);
% Plot styling
grid on;
title('Power Angle Characteristics of Non-Salient Pole Sync Machine');
xlabel('\delta (degree)');
ylabel('Power (p.u.)');
