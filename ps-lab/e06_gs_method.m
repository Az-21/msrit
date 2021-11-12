% Experiment 6
% GS Method
% Abhishek Choudhary
% 1MS18EE003
clc; clear; close all;

n = 3;
V = [1.05, 1, 1];
P = [inf, -2.566, -1.386];
Q = [inf, -1.102, -0.452];

Y =[[complex(20, - 50), complex(- 10, 20), complex(- 10, 30)],
    [complex(- 10, 20), complex(26, - 52), complex(- 16, 32)],
    [complex(- 10, 30), complex(- 16, 32), complex(26, - 62)]];

delta = 1; % error placeholder
iterationCount = 1;

while (delta > 0.00001)
    V_prev = V;
    for i = 2:n
        sumyv = 0;
        for k = 1:n
            if (i ~= k)
                sumyv = sumyv + Y(i, k) * V(k);
            end
        end
        V(i) = (1 / Y(i, i)) * ((P(i) - 1j * Q(i)) / conj(V(i)) - sumyv);
    end

    difference = abs(V(2:n)) - abs(V_prev(2:n));
    delta = max(abs(difference));

    % TODO: add each iteration here
    iterationCount = iterationCount + 1;
end

fprintf('Iteration = %d\n', iterationCount);
fprintf('V2 = %f ∠%f° p.u.\n', abs(V(2)), angle(V(2)) * 180 / pi);
fprintf('V3 = %f ∠%f° p.u.\n', abs(V(3)), angle(V(3)) * 180 / pi);