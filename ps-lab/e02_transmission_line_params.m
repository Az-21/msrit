% Experiment 2
% Transmission line parameters
% Abhishek Choudhary
% 1MS18EE003
clc; clear; close all;

% Parameters
L = 130;
Z1 = complex(0.036, 0.3);
Y1 = complex(0, 4.22 * 10 ^ (- 6));
Vr_ll = 325 * 10 ^ 3;
Ps = 270 * 10 ^ 6;
pf = 0.8;
config = 'T'; % T/P

Z = L * Z1;
Y = L * Y1;

% Short transmission line
if L <= 80
    fprintf('Short transmission line');
    A = 1;
    B = Z;
    C = 0;
    D = 1;
 
    % Medium transmission line (T-config)
elseif L > 80 && L <= 240 && config == 'T'
    fprintf('Medium transmission line (T configuration)');
    A = 1 + (Y * Z) / 2;
    B = Z * (1 + (Y * Z) / 4);
    C = Y;
    D = A;
 
    % Medium transmission line (Pi-config)
elseif L > 80 && L <= 240 && config == 'P'
    fprintf('Medium transmission line (Pi configuration)');
    A = 1 + (Y * Z) / 2;
    B = Z;
    C = Y * (1 + (Y * Z) / 4);
    D = A;
 
    % Long transmission line
else
    fprintf('Long transmission line');
    Zc = sqrt (Z1 / Y1);
    gamma = sqrt (Z1 * Y1);
    A = cosh (gamma * L);
    B = Zc * sinh (gamma * L);
    C = (1 / Zc) * sinh (gamma * L);
    D = A;
end

% Calculations
Vr_ph = Vr_ll / sqrt(3);
Ir_ll = Ps / (sqrt(3) * Vr_ll * pf);
Ir_ph = Ir_ll * exp(- 1j * acos(pf));

Vs_ph = (A * Vr_ph) + (B * Ir_ph);
Is_ph = (C * Vr_ph) + (D * Ir_ph);

% Voltage regulation
regulation = (abs(Vs_ph) / abs(A) - Vr_ph) * 100 / Vr_ph;

% Efficiency
Ps_ph = real(3 * Vs_ph * conj(Is_ph));
Pr_ph = real(3 * Vr_ph * conj(Ir_ph));
efficiency = (Pr_ph / Ps_ph) * 100;

% Verifying AD - BC = 1
ADminusBC = A * D - B * C;

% Output
fprintf('\nL = %d km\n', L);
fprintf('Z = %f + %fi ohm/km\n', real(Z1), imag(Z1));
fprintf('Y = %fi umho/km\n', imag(Y1) * 10 ^ 6);
fprintf('Pr = %d MVA\n', Ps / 10 ^ (6));
fprintf('Vr_ll = %d kV\n', Vr_ll / 1000);
fprintf('Power factor = %f\n\n', pf);
fprintf('A = %f + %fi\n', real(A), imag(A));
fprintf('B = %f + %fi\n', real(B), imag(B));
fprintf('C = %f + %fi\n', real(C), imag(C));
fprintf('D = %f + %fi\n', real(D), imag(D));
fprintf('AD - BC = %f + %fi\n\n', real(ADminusBC), imag(ADminusBC));
fprintf('Vs = %f + %fi V\n', real(Vs_ph), imag(Vs_ph));
fprintf('Is = %f + %fi A\n', real(Is_ph), imag(Is_ph));
fprintf('Voltage Regulation = %f %%\n', regulation);
fprintf('Efficiency = %f %%', efficiency);