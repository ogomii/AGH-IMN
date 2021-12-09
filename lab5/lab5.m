clf;
[S,it,V] = tools.relaksacjaWielosiatkowa();
ts16 = S(16,:); s16 = ts16(ts16~=0);
ts8 = S(8,:); s8 = ts8(ts8~=0); 
ts4 = S(4,:); s4 = ts4(ts4~=0);
ts2 = S(2,:); s2 = ts2(ts2~=0);
ts1 = S(1,:); s1 = ts1(ts1~=0);

ti16 = it(16,:); i16 = ti16(ti16~=0);
ti8 = it(8,:); i8 = ti8(ti8~=0); 
ti4 = it(4,:); i4 = ti4(ti4~=0);
ti2 = it(2,:); i2 = ti2(ti2~=0);
ti1 = it(1,:); i1 = ti1(ti1~=0);
figure();
semilogx(i16,s16,'r', i8,s8,'g', i4,s4,'b', i2,s2,'c', i1,s1,'k');
xlabel('nr iteraciji');
ylabel('S');
ylim([4,8]);
legend(sprintf('k = 16, itMax = %d',length(i16))...
    ,sprintf('k = 8, itMax = %d',length(i8))...
    ,sprintf('k = 4, itMax = %d',length(i4))...
    ,sprintf('k = 2, itMax = %d',length(i2))...
    ,sprintf('k = 1, itMax = %d',length(i1)));


