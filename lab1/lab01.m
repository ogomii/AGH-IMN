clear; clc;
y0 = 1;
lambda = -1;
tmin = 0;
tmax = 5;

%zad1
[y, x] = tools.Euler(y0,0.01,lambda,tmin,tmax);
[y2, x2] = tools.Euler(y0,0.1,lambda,tmin,tmax);
[y3, x3] = tools.Euler(y0,1,lambda,tmin,tmax);
figure();
plot(x, y, '.r', x2, y2, '.g', x3, y3, 'b',x,exp(lambda*x));
title('zad1');
xlabel('t');
ylabel('u(t)');
legend('0.01','0.1','1.0','analytical');
[yError] = tools.EulerError(y, x, lambda);
[y2Error] = tools.EulerError(y2, x2, lambda);
[y3Error] = tools.EulerError(y3, x3, lambda);
figure();
plot(x, yError, '.r', x2, y2Error, '.g', x3, y3Error, 'b');
title('zad1Error');
legend('0.01','0.1','1.0');
xlabel('t');
ylabel('u num - u analit');


%zad2
[yR, xR] = tools.RK2(y0,0.01,lambda,tmin,tmax);
[yR2, xR2] = tools.RK2(y0,0.1,lambda,tmin,tmax);
[yR3, xR3] = tools.RK2(y0,1,lambda,tmin,tmax);
figure();
plot(xR, yR, '.r', xR2, yR2, '.g', xR3, yR3, 'b',x,exp(lambda*x));
title('zad2');
legend('0.01','0.1','1.0','analytical');
xlabel('t');
ylabel('u(t)');
[yREr] = tools.EulerError(yR, xR, lambda);
[yREr2] = tools.EulerError(yR2, xR2, lambda);
[yREr3] = tools.EulerError(yR3, xR3, lambda);
figure();
plot(xR, yREr, '.r', xR2, yREr2, '.g', xR3, yREr3, 'b');
title('zad2Error');
legend('0.01','0.1','1.0');
xlabel('t');
ylabel('u num - u analit');


%zad3
[yRK, xRK] = tools.RK4(y0,0.01,lambda,tmin,tmax);
[yRK2, xRK2] = tools.RK4(y0,0.1,lambda,tmin,tmax);
[yRK3, xRK3] = tools.RK4(y0,1,lambda,tmin,tmax);
figure();
plot(xRK, yRK, '.r', xRK2, yRK2, '.g', xRK3, yRK3, 'b',x,exp(lambda*x));
title('zad3');
legend('0.01','0.1','1.0','analytical');
xlabel('t');
ylabel('u(t)');
[yRKEr] = tools.EulerError(yRK, xRK, lambda);
[yRKEr2] = tools.EulerError(yRK2, xRK2, lambda);
[yRKEr3] = tools.EulerError(yRK3, xRK3, lambda);
figure();
plot(xRK, yRKEr, '.r', xRK2, yRKEr2, '.g', xRK3, yRKEr3, 'b');
title('zad3Error');
legend('0.01','0.1','1.0');
xlabel('t');
ylabel('u num - u analit');


%zad4
[I, Q, x] = tools.RRZ2(0.5);
[I2, Q2, x2] = tools.RRZ2(0.8);
[I3, Q3, x3] = tools.RRZ2(1.0);
[I4, Q4, x4] = tools.RRZ2(1.2);
figure();
%plot(x, Q, '.r', x, I, '.g', x2, Q2, 'b--o', x2, I2, 'r--o', x3, Q3 ,'c*', x3, I3, 'y*', x4, Q4, ':', x4, I4, ':');
plot(x, Q, '.r', x2, Q2, 'b--o', x3, Q3 ,'c*', x4, Q4, ':');
title('Q(t)');
legend('0.5','0.8','1.0','1.2');
xlabel('t');
ylabel('Q(t)');
figure();
plot(x, I, '.r', x2, I2, 'b--o', x3, I3, 'c*', x4, I4, ':');
title('I(t)');
legend('0.5','0.8','1.0','1.2');
xlabel('t');
ylabel('I(t)');

%{ 
4 w 4
subplot(2,2,1);
plot(x, Q, '.r', x, I, '.g');
subplot(2,2,2);
plot(x2, Q2, '.r', x2, I2, '.g');
subplot(2,2,3);
plot(x3, Q3, '.r', x3, I3, '.g');
subplot(2,2,4);
plot(x4, Q4, '.r', x4, I4, '.g');
%}

figure();
subplot(4,2,1);
plot(x, Q, '.r');
title({'Q(t)','0.5'});
subplot(4,2,2);
plot(x, I, '.g');
title({'I(t)','0.5'});
subplot(4,2,3);
plot(x2, Q2, '.r');
title('0.8');
subplot(4,2,4);
plot(x2, I2, '.g');
title('0.8');
subplot(4,2,5);
plot(x3, Q3, '.r');
title('1.0');
subplot(4,2,6);
plot(x3, I3, '.g');
title('1.0');
subplot(4,2,7);
plot(x4, Q4, '.r');
title('1.2');
subplot(4,2,8);
plot(x4, I4, '.g');
title('1.2');


