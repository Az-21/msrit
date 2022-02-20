clc; clear; close all;

% ---------------------------------------------------------------------------- %
%                                Swing Equation                                %
% ---------------------------------------------------------------------------- %

% Params
x1 = 0.45; % transfer reactance before fault
x2 = 1.25; % transfer reactance during fault
x3 = 0.55; % transfer reactance after fault
Eg = 1.1; % generator voltage
V = 1; % terminal voltage
Pe = 0.9; %
f = 50; % frequency
M = 0.016; % inertia

% Calculations
Pm = Pe;
Pm1 = Eg*V/x1;
Pm2 = Eg*V/x2;
Pm3 = Eg*V/x3;

d0 = asin(Pm/Pm1);
dmax = pi - asin(Pm/Pm3);

dr = ((Pm*(dmax-d0)) - (Pm2*cos(d0)) + (Pm3*cos(dmax)))/(Pm3 - Pm2);
dcr1 = acos(dr);
dcr = acosd(dr);
tcr = sqrt((2*M*(dcr1-d0)/(Pm)));
