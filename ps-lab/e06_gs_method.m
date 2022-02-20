clc; clear; close all;

% ---------------------------------------------------------------------------- %
%                              Gauss–Seidel Method                             %
% ---------------------------------------------------------------------------- %

n = 3;
V = [1.05, 1, 1];
P = [inf, -2.566, -1.386];
Q = [inf, -1.102, -0.452];

Y = [
    [complex(20, - 50), complex(- 10, 20), complex(- 10, 30)]
    [complex(- 10, 20), complex(26, - 52), complex(- 16, 32)]
    [complex(- 10, 30), complex(- 16, 32), complex(26, - 62)]];

% Input params
fprintf('Number of busses = %d\n', n);
fprintf('P = %f | %f | %f p.u.\n', P(1), P(2), P(3));
fprintf('Q = %f | %f | %f p.u.\n', Q(1), Q(2), Q(3));
fprintf('Ybus = \n');
disp(Y);

% GS Loop
delta = 1; % error between two consecutive iterations
iterationCount = 1;

while delta > 0.00001
    V_prev = V; % to calculate delta at the end of iteration

    for i = 2:n
        relationalCorrection = 0;

        for k = 1:n

            if (i ~= k)
                relationalCorrection = relationalCorrection + Y(i, k) * V(k);
            end

        end

        selfCorrection = (P(i) - 1j * Q(i)) / conj(V(i));
        V(i) = (selfCorrection - relationalCorrection) / Y(i, i);
    end

    difference = abs(V(2:n)) - abs(V_prev(2:n));
    delta = max(abs(difference));

    fprintf('V2(%d) = %f + %fi\n', iterationCount, real(V(2)), imag(V(2)));
    fprintf('V3(%d) = %f + %fi\n', iterationCount, real(V(3)), imag(V(3)));
    iterationCount = iterationCount + 1;
end

% Output
fprintf('\nTotal iterations = %d\n', iterationCount - 1);
fprintf('V2 = %f ∠%f° p.u.\n', abs(V(2)), angle(V(2)) * 180 / pi);
fprintf('V3 = %f ∠%f° p.u.\n', abs(V(3)), angle(V(3)) * 180 / pi);
