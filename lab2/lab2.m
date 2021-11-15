clear; clc; clf;
N = 500;

%zad1 Metoda Picarda
u = tools.Picard(N);
z = N - u;
t = 0:0.1:100;
figure();
plot(t,u,'.r', t, z, '.b');
title("metoda Picarda");
legend("u(t)","z(t)");
xlabel("t");
ylabel("people");

%zad2 iteracja Newtona
u2 = tools.Newton(N);
z2 = N - u;
figure();
plot(t,u2,'.r', t, z2, '.b');
title("iteracja Newtona");
legend("u(t)","z(t)");
xlabel("t");
ylabel("people");

%zad3 RK2
u3 = tools.RK2(N);
z3 = N - u;
figure();
plot(t,u3,'.r', t, z3, '.b');
title("RK2");
legend("u(t)","z(t)");
xlabel("t");
ylabel("people");
