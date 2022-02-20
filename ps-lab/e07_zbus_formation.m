clc; clear; close all;

% ---------------------------------------------------------------------------- %
%                                Z Bus Formation                               %
% ---------------------------------------------------------------------------- %

% Start, end, impedance, modification type (1/2/3/4)
data = [
    [1, 2, 0.1, 1]
    [2, 3, 0.5, 2]
    [3, 1, 0.2, 3]];

% Properties of Zbus
elements = length(data(:, 1));
Zbus = zeros(1, 1);
stepCount = 0;

% -------------------------- Zbus building algorithm ------------------------- %
for i = 1:elements
    % Initialize values
    sb = data(i, 1);
    eb = data(i, 2);
    oncomingElement = data(i, 3);

    % Swap values if starting bus > ending bus
    if (sb > eb)
        temp = sb;
        sb = eb;
        eb = temp;
    end

    % Type 1 and Type 2 modification
    if (data(i, 4) <= 2)
        zncol = Zbus(:, sb);
        znrow = Zbus(sb, :);
        zn_dia = Zbus(sb, sb) + oncomingElement;
        Zbus = [Zbus zncol; znrow zn_dia];

    % Type 3 and Type 4 modification
    else
        zncol = Zbus(:, sb) - Zbus(:, eb);
        znrow = Zbus(sb, :) - Zbus(eb, :);
        zn_dia = Zbus(sb, sb) + Zbus(eb, eb) - 2 * Zbus(sb, eb) + oncomingElement;
        Zbus = [Zbus] - [(zncol * znrow) / zn_dia]; % size of matrix remains same
    end

    % Output
    stepCount = stepCount + 1;
    fprintf('Step %d | Type %d modification\n', stepCount, data(i, 4));

    if i ~= elements
        fprintf('Zbus(new) =\n');
    else
        fprintf('Zbus(final) =\n');
    end

    disp(Zbus(2:end, 2:end));
end
