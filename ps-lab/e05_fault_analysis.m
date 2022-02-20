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
fprintf('3 -> Double line to ground fault');
faultType = input('');
fprintf('\n');

% --------------------------- Symmertic components --------------------------- %

% Line to ground fault
if faultType == 1
    fprintf('Single line to ground fault selected\n');

    Ia1_pu = Ea / (Z0 + Z1 + Z2);
    Ia2_pu = Ia1_pu;
    Ia0_pu = Ia1_pu;

    Va1_pu = Ea - Ia1_pu * Z1;
    Va2_pu =- 1 * Ia2_pu * Z2;
    Va0_pu =- 1 * Ia0_pu * Z0;

% Line to line fault
elseif faultType == 2
    fprintf('Line to line fault selected\n');

    Ia1_pu = Ea / (Z1 + Z2);
    Ia2_pu =- 1 * Ia1_pu;
    Ia0_pu = 0;

    Va1_pu = Ea - Ia1_pu * Z1;
    Va2_pu = Va1_pu;
    Va0_pu = 0; % neutral is grounded

% Double line to ground fault
else
    fprintf('Double line to ground fault selected\n');

    Ia1_pu = Ea / (Z1 + Z2 * Z0 / (Z2 + Z0));
    Va1_pu = Ea - Ia1_pu * Z1;
    Va2_pu = Va1_pu;
    Va0_pu = Va1_pu;
    Ia2_pu =- 1 * Va2_pu / Z2;
    Ia0_pu =- 1 * Va0_pu / Z0;
end

% Fault currents
Ia_pu = Ia1_pu + Ia2_pu + Ia0_pu;
Ib_pu = alpha^2 * Ia1_pu + alpha * Ia2_pu + Ia0_pu;
Ic_pu = alpha * Ia1_pu + alpha^2 * Ia2_pu + Ia0_pu;

% Fault voltages
Va_pu = Va1_pu + Va2_pu + Va0_pu;
Vb_pu = alpha^2 * Va1_pu + alpha * Va2_pu + Va0_pu;
Vc_pu = alpha * Va1_pu + alpha^2 * Va2_pu + Va0_pu;

% Line to line voltages
Vab_pu = Va_pu - Vb_pu;
Vbc_pu = Vb_pu - Vc_pu;
Vca_pu = Vc_pu - Va_pu;

% Conversion from p.u. to normal current
base = P / (sqrt(3) * V);
Ia = Ia_pu * base;
Ib = Ib_pu * base;
Ic = Ic_pu * base;

% Conversion from p.u. to normal voltage
base = V / sqrt(3);
Vab = Vab_pu * base;
Vbc = Vbc_pu * base;
Vca = Vca_pu * base;

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
