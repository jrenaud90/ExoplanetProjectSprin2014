clear all
load('confirmed.mat','-mat')
load('KOI_Rad.mat','-mat')
load('KTCE5sig.mat','-mat')

figure(1)
hist(Confirmed{1,2},100)
title('Confirmed Planets')
xlabel('Radius (Earth Radii)')
figure(2)
hist(koi_dataSM(:,2),300)
title('KOI Planets')
xlabel('Radius (Earth Radii)')
figure(3)
hist(koi_dataSM(:,2),300)
axis([0 35 0 150])
title('KOI Planets')
xlabel('Radius (Earth Radii)')
figure(4)
hist(data_5sig(:,2),1000)
title('5sig')
xlabel('Radius (Earth Radii)')