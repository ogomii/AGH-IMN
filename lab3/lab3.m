clear; clf; clc;

%zad 1
[Rx1, Rv1, Rdt1, Rt1] = tools.timeControl(1e-2, @tools.RK2);
[Rx2, Rv2, Rdt2, Rt2] = tools.timeControl(1e-5, @tools.RK2);
plot(Rt1, Rx1, 'g', Rt2, Rx2, 'r');
title('x(t)');
legend('tol = 1e-2','tol = 1e-5');

figure();
plot(Rt1, Rv1, 'g', Rt2, Rv2, 'r');
title('v(t)');
legend('tol = 1e-2','tol = 1e-5');

figure();
plot(Rt1, Rdt1, 'g', Rt2, Rdt2, 'r');
title('dt(t)');
legend('tol = 1e-2','tol = 1e-5');

figure();
plot(Rx1, Rv1, 'g', Rx2, Rv2, 'r');
title('v(x)');
legend('tol = 1e-2','tol = 1e-5');

%zad 2
[Tx1, Tv1, Tdt1, Tt1] = tools.timeControl(1e-2, @tools.metodaTrapezow);
[Tx2, Tv2, Tdt2, Tt2] = tools.timeControl(1e-5, @tools.metodaTrapezow);
figure();
plot(Tt1, Tx1, 'g', Tt2, Tx2, 'r');
title('x(t)');
legend('tol = 1e-2','tol = 1e-5');

figure();
plot(Tt1, Tv1, 'g', Tt2, Tv2, 'r');
title('v(t)');
legend('tol = 1e-2','tol = 1e-5');

figure();
plot(Tt1, Tdt1, 'g', Tt2, Tdt2, 'r');
title('dt(t)');
legend('tol = 1e-2','tol = 1e-5');

figure();
plot(Tx1, Tv1, 'g', Tx2, Tv2, 'r');
title('v(x)');
legend('tol = 1e-2','tol = 1e-5');
