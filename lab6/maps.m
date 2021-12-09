clf;

M = dlmread('Vn50.dat');
mapa = pcolor(M);
set(mapa, 'EdgeColor', 'none');
colorbar
title('nx=ny=50');

figure();
M = dlmread('Vn100.dat');
mapa = pcolor(M);
set(mapa, 'EdgeColor', 'none');
colorbar
title('nx=ny=100');

figure();
M = dlmread('Vn200.dat');
mapa = pcolor(M);
set(mapa, 'EdgeColor', 'none');
colorbar
title('nx=ny=200');


figure();
M = dlmread('Ve11.dat');
mapa = pcolor(M);
set(mapa, 'EdgeColor', 'none');
caxis([-0.8,0.8])
colorbar
title('nx=ny=100, e1=1, e2=1');

figure();
M = dlmread('Ve12.dat');
mapa = pcolor(M);
set(mapa, 'EdgeColor', 'none');
caxis([-0.8,0.8])
colorbar
title('nx=ny=100, e1=1, e2=2');

figure();
M = dlmread('Ve10.dat');
mapa = pcolor(M);
set(mapa, 'EdgeColor', 'none');
caxis([-0.8,0.8])
colorbar
title('nx=ny=100, e1=1, e2=10');
