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
con2 = log10(10.9769*pl_radj); %2009+
con3 = log10(ConData); %2010+

condist = con2;
koidist = koi;
trandist = tran;

[Nconf,xconf]=hist(con,40);
[Nconf2,xconf2]=hist(con2,40);
[Nconf3,xconf3]=hist(con3,40);
[Nkoi,xkoi]=hist(koi,40);
[Ntran,xtran]=hist(tran,40);
predx = log10([mean(1,2),mean(2,4),mean(4,8),mean(8,10)]);
predy = [.281,.353,.064,.04]*length(koi);
count = 1; 
for i = 1:length(con2)
    if con2(i)> 0.4
        if con2(i) <1
            confirmedData(count) = con2(i);
            count = count + 1;
        end
    end
end
count = 1; 
for i = 1:length(koi)
    if koi(i)> 0.4
        if koi(i) <1
            koiData(count) = koi(i);
            count = count + 1;
        end
    end
end
count = 1; 
for i = 1:length(tran)
    if tran(i)> 0.4
        if tran(i) <1
            tranData(count) = tran(i);
            count = count + 1;
        end
    end
end
%%plotting
% figure(2)
 NNconf2 = Nconf2/sum(Nconf2);
% stairs(xconf2,NNconf2,'k','LineWidth',2); 
% hold on
% NNkoi = Nkoi/sum(Nkoi);
% stairs(xkoi,NNkoi,'b','LineWidth',2);
% NNtran = Ntran/sum(Ntran);
% stairs(xtran,NNtran,'r','LineWidth',2);
% grid on
% scatter(predx,predy/sum(predy),'.k');
% hold off
% xlabel('R/R_{Earth} (Log Scale)')
% ylabel('Events (Normalized)')
% hleg1 = legend('Confirmed Planets','KOI Objects','K-transit events');
% figure(3)
% stairs(xconf2,Nconf2/sum(Nconf2),'k','LineWidth',2); 
% hold on
% stairs(xkoi,Nkoi/sum(Nkoi),'b','LineWidth',2);
% stairs(xtran,Ntran/sum(Ntran),'r','LineWidth',2);
% grid on
% hold off
% xlabel('R/R_{Earth} (Log Scale)')
% ylabel('Events (Normalized)')
% hleg1 = legend('Confirmed Planets','KOI Objects','K-transit events');
% figure(4)
% stairs(xconf3,Nconf3/sum(Nconf3),'k','LineWidth',2); 
% hold on
% stairs(xkoi,Nkoi/sum(Nkoi),'b','LineWidth',2);
% stairs(xtran,Ntran/sum(Ntran),'r','LineWidth',2);
% grid on
% hold off
% xlabel('R/R_{Earth} (Log Scale)')
% ylabel('Events (Normalized)')
% hleg1 = legend('Confirmed Planets','KOI Objects','K-transit events');

%%Probability
xprob = xconf2;
probvect = zeros(1,40);
probss(1,:) = log10([1.4,2,2.8,4,5.7,8,11.6,16]);
probss(2,:) = [0.12,0.142,0.186,0.059,0.019,.01,.009,0.007];
for i = 1:length(xprob);
    ind = find(probss(1,:)<=(xprob(i)+0.05)); %Change +0.0 to 0.1
    if isempty(ind)
        probvect(i) = 0;
    else
    probvect(i) = probss(2,max(ind));
    end
end
nprob = (max(NNconf2)/max(probvect))*probvect;
figure(4)
stairs(xprob,nprob,'b','LineWidth',2); hold on 
stairs(xconf2,Nconf2/sum(Nconf2),'k','LineWidth',2);

%%Randn
l = length(nprob);
scale = max(NNconf2)/max(probvect);
for i = 1:100
nrprob(i,:) = nprob+ randn(1,l).*(scale*(1/100));
nrprob(find(nrprob(i,:)<0))=0;
end
for i = 1:length(xprob)
    npp(i) = mean(nrprob(:,i));
end
figure(5)
stairs(xprob,nrprob(1,:),'b','LineWidth',2); hold on 
stairs(xconf2,Nconf2/sum(Nconf2),'k','LineWidth',2)
figure(6)
stairs(xprob,npp,'b','LineWidth',2); hold on 
stairs(xconf2,Nconf2/sum(Nconf2),'k','LineWidth',2)
figure(7)
for i = 1:40
    stairs(xprob,nrprob(i,:),'b','LineWidth',2); hold on 
end
stairs(xconf2,Nconf2/sum(Nconf2),'k','LineWidth',4)