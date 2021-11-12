% Experiment 7
% Z Bus
% Abhishek Choudhary
% 1MS18EE003
clc; clear; close all;

% Tabular data (Question 1)
% Start, end, impedance, modification type
data = [[1, 2, 0.1, 1],
        [2, 3, 0.5, 1],
        [3, 1, 0.2, 2]];

% Zbus building algorithm
n = max(max(data(:, 1)), max(data(:, 2)));
nbr = length(data(:, 1));
Zbus = zeros(1, 1);
for i = 1:1:nbr
    if (data(i, 4) == 1)
        sb = data(i, 1);
        eb = data(i, 2);
        if (sb > eb)
            temp = sb;
            sb = eb;
            eb = temp;
        end
        zncol = Zbus(:, sb);
        znrow = Zbus(sb, :);
        zn_dia = Zbus(sb, sb) + data(i, 3);
        Zbus = [Zbus zncol; znrow zn_dia];
    end
    if (data(i, 4) == 2)
        sb = data(i, 1);
        eb = data(i, 2);
        if (sb > eb)
            temp = sb;
            sb = eb;
            eb = temp;
        end
        zncol = Zbus(:, sb) - Zbus(:, eb);
        znrow = Zbus(sb, :) - Zbus(eb, :);
        zn_dia = Zbus(sb, sb) + Zbus(eb, eb) - 2 * Zbus(sb, eb) + data(i, 3);
        Zbus = [Zbus] - [(zncol * znrow) / zn_dia];
    end
end
Zbus = Zbus(2:n, 2:n);

% Output
disp('Zbus =');
disp(Zbus);