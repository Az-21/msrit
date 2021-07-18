% assumed values
m = 1000;
b = 50;
u = 500;

% transfer function
s = tf('s');
P_cruise = 1/(m*s + b);

% P-Z plot
pzmap(P_cruise);