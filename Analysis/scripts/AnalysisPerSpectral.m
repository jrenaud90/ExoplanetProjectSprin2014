clear all
data = load('SpTypeReduced18Jmassredu_noradconsid.csv');
l = length(data(:,4));
Radius=NaN*ones(3,l);
Mass=NaN*ones(3,l);
Period=NaN*ones(3,l);
for i =1:l
    indx = data(i,4);
    if ~isnan(data(i,3))
        Radius(indx,sum(~isnan(Radius(indx,:)))+1)=data(i,3);
    end
    if ~isnan(data(i,2))
        Mass(indx,sum(~isnan(Mass(indx,:)))+1)=data(i,2);
    end    
    if ~isnan(data(i,1))
        Period(indx,sum(~isnan(Period(indx,:)))+1)=data(i,1);
    end
end
%%Number per sptype, For labeling.
for i=1:3
    R(i,1)=sum(~isnan(Radius(i,:)));
    M(i,1)=sum(~isnan(Mass(i,:)));
    P(i,1)=sum(~isnan(Period(i,:)));
    Rst{i}=num2str(R(i,1));
    Mst{i}=num2str(M(i,1));
    Pst{i}=num2str(P(i,1));
end
%%Plotting

sr2=['M','K','G'];
figure('Name','RMPvS','Visible','off')
count = 1;
for k=1:3
    for j=1:3
        subplot(3,3,count)
        if k == 1
            hist(Radius(j,:),7);
            sr = strcat('Radius:',sr2(j),',Sample:',Rst{j});
            xlabel(sr)
        elseif k == 2
            hist(Mass(j,:),15);
            sr = strcat('Mass:',sr2(j),',Sample:',Mst{j});
            xlabel(sr)
        else
            hist(Period(j,:),15);
            sr = strcat('Period:',sr2(j),',Sample:',Pst{j});
            xlabel(sr)
        end
        count = count + 1;
    end
end
file=['APS_out\','RMPvS','.png'];
print('-dpng',file)

%%Resample%%%
Comp=100;
for j=1:3
    rindx=sum(~isnan(Radius(j,:)));
    mindx=sum(~isnan(Mass(j,:)));
    pindx=sum(~isnan(Period(j,:)));
    for i=1:Comp*rindx
    RI = randi(rindx);
    RadiusBoot(j,i)=Radius(j,RI);
    end
    for i=1:Comp*mindx
    RI = randi(mindx);
    MassBoot(j,i)=Mass(j,RI);
    end
    for i=1:Comp*pindx
    RI = randi(pindx);
    PeriodBoot(j,i)=Period(j,RI);
    end
end

%%Number per sptype, For labeling.
for i=1:3
    R(i,1)=sum(~isnan(RadiusBoot(i,:)));
    M(i,1)=sum(~isnan(MassBoot(i,:)));
    P(i,1)=sum(~isnan(PeriodBoot(i,:)));
    Rst{i}=num2str(R(i,1));
    Mst{i}=num2str(M(i,1));
    Pst{i}=num2str(P(i,1));
end
%%Plotting

sr2=['M','K','G'];
figure('Name','RMPvS_Boot','Visible','off')
count = 1;
for k=4:6
    for j=1:3
        subplot(3,3,count)
        if k == 4
            hist(RadiusBoot(j,:));
            sr = strcat('Radius:',sr2(j),',Sample:',Rst{j});
            xlabel(sr)
            file2='BootStrappedRadii';
        elseif k == 5
            hist(MassBoot(j,:),20);
            sr = strcat('Mass:',sr2(j),',Sample:',Mst{j});
            xlabel(sr)
            file2='BootStrappedMass';
        else
            hist(PeriodBoot(j,:),20);
            sr = strcat('Period:',sr2(j),',Sample:',Pst{j});
            xlabel(sr)
            file2='BootStrappedPeriod';
        end
        count = count +1;
    end
end
file=['APS_out\','RMPvS_Boot','.png'];
print('-dpng',file)



%%
Tail = 1;
count = 1;
count2 = 1;
count3 =1;
for i = [0.5,0.1,0.05,0.01,0.005,0.001,0.0005,0.0001]
    for j=1:3
        for k =1:3
            hr = kstest2(Radius(j,:),Radius(k,:),'Alpha',i);
            if hr == 1
                testr(count,1) = i;
                testr(count,2) = j;
                testr(count,3) = k;
                count = count +1;
            end
            hm = kstest2(Mass(j,:),Mass(k,:),'Alpha',i);
            if hm == 1
                testm(count2,1) = i;
                testm(count2,2) = j;
                testm(count2,3) = k;
                count2 = count2 +1;
            end
            hp = kstest2(Period(j,:),Period(k,:),'Alpha',i);
            if hp == 1
                testp(count3,1) = i;
                testp(count3,2) = j;
                testp(count3,3) = k;
                count3 = count3 +1;
            end
        end
    end
end
count = 1;
count2 = 1;
count3 =1;
for i = [0.5,0.1,0.05,0.01,0.005,0.001,0.0005,0.0001]
    for j=1:3
        for k =1:3
            hr = kstest2(RadiusBoot(j,:),RadiusBoot(k,:),'Alpha',i);
            if hr == 1
                testrb(count,1) = i;
                testrb(count,2) = j;
                testrb(count,3) = k;
                count = count +1;
            end
            hm = kstest2(MassBoot(j,:),MassBoot(k,:),'Alpha',i);
            if hm == 1
                testmb(count2,1) = i;
                testmb(count2,2) = j;
                testmb(count2,3) = k;
                count2 = count2 +1;
            end
            hp = kstest2(PeriodBoot(j,:),PeriodBoot(k,:),'Alpha',i);
            if hp == 1
                testpb(count3,1) = i;
                testpb(count3,2) = j;
                testpb(count3,3) = k;
                count3 = count3 +1;
            end
        end
    end
end
        