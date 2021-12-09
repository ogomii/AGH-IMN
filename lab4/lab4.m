%zad1
[S,it, blad, V] = tools.relaksacjaGlobalna(1.0);
[S2, it2, blad2, V2] = tools.relaksacjaGlobalna(0.6);
semilogx(it, S, 'r', it2, S2, 'b');
legend('wG = 1.0','wG = 0.6');
xlabel('it');
ylabel('S');
figure();
mapa = pcolor(blad');
set(mapa, 'EdgeColor', 'none');
colormap
colorbar
legend('wG = 1.0');
figure();
mapa2 = pcolor(blad2');
set(mapa2, 'EdgeColor', 'none');
colormap
colorbar
legend('wG = 0.6');

%zad2
%%
[S3,it3] = tools.relaksacjaLokalna(1.0);
[S4, it4] = tools.relaksacjaLokalna(1.4);
[S5,it5] = tools.relaksacjaLokalna(1.8);
[S6, it6] = tools.relaksacjaLokalna(1.9);
figure();
semilogx(it3, S3, 'r', it4, S4, 'b', it5, S5, 'c', it6, S6, 'g');
legend('wG = 1.0','wG = 1.4','wG = 1.8','wG = 1.9');
xlabel('it');
ylabel('S');
