clear all
load('confirmed.mat','-mat')
load('KOI_Rad2.mat','-mat')
load('KTCE5sig.mat','-mat')
load('confirmed2009up.mat','-mat')
load('confirmed2011up.mat','-mat')

data_5sig(find(data_5sig(:,2)==0),2)=NaN;
con = log10(Confirmed{1,2});
koi = log10(KOIrad);
tran = log10(data_5sig(:,2));
con2 = log10(10.9769*pl_radj);
con3 = log10(ConData);

[Nconf,xconf]=hist(con,40);
[Nconf2,xconf2]=hist(con2,40);
[Nconf3,xconf3]=hist(con3,40);
[Nkoi,xkoi]=hist(koi,40);
[Ntran,xtran]=hist(tran,40);
predx = log10([mean(1,2),mean(2,4),mean(4,8),mean(8,10)]);
predy = [.281,.353,.064,.04]*length(koi);

figure(2)
NNconf2 = Nconf2/sum(Nconf2);
stairs(xconf2,NNconf2,'k','LineWidth',2); 
hold on
NNkoi = Nkoi/sum(Nkoi);
stairs(xkoi,NNkoi,'b','LineWidth',2);
NNtran = Ntran/sum(Ntran);
stairs(xtran,NNtran,'r','LineWidth',2);
grid on
scatter(predx,predy/sum(predy),'.k');
hold off
xlabel('R/R_{Earth} (Log Scale)')
ylabel('Events (Normalized)')
hleg1 = legend('Confirmed Planets','KOI Objects','K-transit events');
figure(3)
stairs(xconf2,Nconf2/sum(Nconf2),'k','LineWidth',2); 
hold on
stairs(xkoi,Nkoi/sum(Nkoi),'b','LineWidth',2);
stairs(xtran,Ntran/sum(Ntran),'r','LineWidth',2);
grid on
hold off
xlabel('R/R_{Earth} (Log Scale)')
ylabel('Events (Normalized)')
hleg1 = legend('Confirmed Planets','KOI Objects','K-transit events');
figure(4)
stairs(xconf3,Nconf3/sum(Nconf3),'k','LineWidth',2); 
hold on
stairs(xkoi,Nkoi/sum(Nkoi),'b','LineWidth',2);
stairs(xtran,Ntran/sum(Ntran),'r','LineWidth',2);
grid on
hold off
xlabel('R/R_{Earth} (Log Scale)')
ylabel('Events (Normalized)')
hleg1 = legend('Confirmed Planets','KOI Objects','K-transit events');