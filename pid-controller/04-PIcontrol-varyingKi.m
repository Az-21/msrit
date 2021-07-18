% system params
m = 1000;
b = 50;
r = 10;

% open-loop
s = tf('s');
P_cruise = 1/(m*s + b);

%-------------------------
%-------------------------

% PID params
Kp = 800;
Ki = 10;
Kd = 0;

% transfer function
C = pid(Kp, Ki, Kd);                % controller
T = feedback(C * P_cruise, 1);

% plot
step(r * T);

hold on;

% PID params
Kp = 800;
Ki = 40;
Kd = 0;

% transfer function
C = pid(Kp, Ki, Kd);                % controller
T = feedback(C * P_cruise, 1);

% plot
step(r * T);

hold on;

% PID params
Kp = 800;
Ki = 50;
Kd = 0;

% transfer function
C = pid(Kp, Ki, Kd);                % controller
T = feedback(C * P_cruise, 1);

% plot
step(r * T);

hold on;

% PID params
Kp = 800;
Ki = 1000;
Kd = 0;

% transfer function
C = pid(Kp, Ki, Kd);                % controller
T = feedback(C * P_cruise, 1);

% plot
step(r * T);