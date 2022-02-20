clc; clear; close all;

% ---------------------------------------------------------------------------- %
%                                Fault analysis                                %
% ---------------------------------------------------------------------------- %

% Params
P = 20 * 10^6;
V = 13.8 * 10^3;
Z1 = complex(0, 0.25);
Z2 = complex(0, 0.35);
Z0 = complex(0, 0.10);
Ea = 1; % V_internal = V_terminal at no load
alpha = 1 * exp(1j * 120 * pi / 180); % 120, 240, 360

% Type of fault
fprintf('Select the type of fault\n');
fprintf('1 -> Line to ground fault\n');
fprintf('2 -> Line to line fault\n');
fprintf('3 -> Double line to ground fault\n');
faultType = input('Fault type: ');
fprintf('\n');

% --------------------------- Symmertic components --------------------------- %

% Line to ground fault
if faultType == 1
    fprintf('Single line to ground fault selected\n');

    Ia1 = Ea / (Z0 + Z1 + Z2);
    Ia2 = Ia1;
    Ia0 = Ia1;

    Va1 = Ea - Ia1 * Z1;
    Va2 =- 1 * Ia2 * Z2;
    Va0 =- 1 * Ia0 * Z0;

% Line to line fault
elseif faultType == 2
    fprintf('Line to line fault selected\n');

    Ia1 = Ea / (Z1 + Z2);
    Ia2 =- 1 * Ia1;
    Ia0 = 0;

    Va1 = Ea - Ia1 * Z1;
    Va2 = Va1;
    Va0 = 0; % neutral is grounded

% Double line to ground fault
else
    fprintf('Double line to ground fault selected\n');

    Ia1 = Ea / (Z1 + Z2 * Z0 / (Z2 + Z0));
    Va1 = Ea - Ia1 * Z1;
    Va2 = Va1;
    Va0 = Va1;
    Ia2 =- 1 * Va2 / Z2;
    Ia0 =- 1 * Va0 / Z0;
end

% Fault currents
Ia = Ia1 + Ia2 + Ia0;
Ib = alpha^2 * Ia1 + alpha * Ia2 + Ia0;
Ic = alpha * Ia1 + alpha^2 * Ia2 + Ia0;

% Fault voltages
Va = Va1 + Va2 + Va0;
Vb = alpha^2 * Va1 + alpha * Va2 + Va0;
Vc = alpha * Va1 + alpha^2 * Va2 + Va0;

% Line to line voltages
Vab = Va - Vb;
Vbc = Vb - Vc;
Vca = Vc - Va;

% Conversion from p.u. to normal current
base = P / (sqrt(3) * V);
Ia = Ia * base;
Ib = Ib * base;
Ic = Ic * base;

% Conversion from p.u. to normal voltage
base = V / sqrt(3);
Vab = Vab * base;
Vbc = Vbc * base;
Vca = Vca * base;

% Output (in angle form)
fprintf('P = %f MVA\n', P * 10^(- 6));
fprintf('I = %f kV\n', V * 10^(- 3));
fprintf('Z1 = %fj p.u.\n', imag(Z1));
fprintf('Z2 = %fj p.u.\n', imag(Z2));
fprintf('Z0 = %fj p.u.\n\n', imag(Z0));

fprintf('Ia = %f ∠%f kA\n', abs(Ia) / 1000, angle(Ia) * 180 / pi);
fprintf('Ib = %f ∠%f kA\n', abs(Ib) / 1000, angle(Ib) * 180 / pi);
fprintf('Ic = %f ∠%f kA\n\n', abs(Ic) / 1000, angle(Ic) * 180 / pi);

fprintf('Vab = %f ∠%f kV\n', abs(Vab) / 1000, angle(Vab) * 180 / pi);
fprintf('Vbc = %f ∠%f kV\n', abs(Vbc) / 1000, angle(Vbc) * 180 / pi);
fprintf('Vca = %f ∠%f kV\n', abs(Vca) / 1000, angle(Vca) * 180 / pi);
