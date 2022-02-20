clc; clear; close all;

% ---------------------------------------------------------------------------- %
%                         Transmission line parameters                         %
% ---------------------------------------------------------------------------- %

% Parameters
L = 130;
Z = L * complex(0.036, 0.3);
Y = L * complex(0, 4.22 * 10^(- 6));
Vr_ll = 325 * 10^3;
Ps = 270 * 10^6;
pf = 0.8;
config = 'T'; % T/Pi

% Short transmission line
if L <= 80
    fprintf('Short transmission line');
    A = 1;
    B = Z;
    C = 0;

    % Medium transmission line (T-config)
elseif L > 80 && L <= 240 && config == 'T'
    fprintf('Medium transmission line (T configuration)');
    A = 1 + (Y * Z) / 2;
    B = Z * (1 + (Y * Z) / 4);
    C = Y;

    % Medium transmission line (Pi-config)
elseif L > 80 && L <= 240 && config == 'P'
    fprintf('Medium transmission line (Pi configuration)');
    A = 1 + (Y * Z) / 2;
    B = Z;
    C = Y * (1 + (Y * Z) / 4);

    % Long transmission line
else
    fprintf('Long transmission line');
    Zc = sqrt (Z / Y);
    gamma = sqrt (Z * Y);

    A = cosh (gamma);
    B = Zc * sinh (gamma);
    C = (1 / Zc) * sinh (gamma);
end

% Commmon transmission line parameter
D = A;

% Calculations
Vr_ph = Vr_ll / sqrt(3);
Ir_ll = Ps / (sqrt(3) * Vr_ll);
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
fprintf('Z = %f + %fi ohm/km\n', real(Z), imag(Z));
fprintf('Y = %fi umho/km\n', imag(Y) * 10^6);
fprintf('Pr = %d MVA\n', Ps / 10^(6));
fprintf('Vr_ll = %d kV\n', Vr_ll / 1000);
fprintf('Power factor = %f\n\n', pf);

fprintf('A = %f + %fi\n', real(A), imag(A));
fprintf('B = %f + %fi\n', real(B), imag(B));
fprintf('C = %f + %fi\n', real(C), imag(C));
fprintf('D = %f + %fi\n', real(D), imag(D));
fprintf('AD - BC = %f + %fi\n\n', real(ADminusBC), imag(ADminusBC));

fprintf('Vs = %f ∠%f° kV\n', abs(Vs_ph) / 1000, angle(Vs_ph) * 180 / pi);
fprintf('Is = %f ∠%f° kA\n', abs(Is_ph) / 1000, angle(Is_ph) * 180 / pi);
fprintf('Voltage Regulation = %f %%\n', regulation);
fprintf('Efficiency = %f %%', efficiency);
