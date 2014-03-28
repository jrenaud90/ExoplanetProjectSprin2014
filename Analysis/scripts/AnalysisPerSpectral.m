clear all
data = load('SpTypeReduced.csv');
Radius=NaN*ones(3,556);
Mass=NaN*ones(3,556);
Period=NaN*ones(3,556);
for i =1:556
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
for k=1:3
    figure('Name',num2str(k),'Visible','off')
    for j=1:3
        subplot(1,3,j)
        if k == 1
            hist(Radius(j,:),ceil(sum(~isnan(Radius(j,:)))/5));
            sr = strcat('Radius:',sr2(j),',Sample:',Rst{j});
            xlabel(sr)
            file2='Radii';
        elseif k == 2
            hist(Mass(j,:),ceil(sum(~isnan(Mass(j,:)))/20));
            sr = strcat('Mass:',sr2(j),',Sample:',Mst{j});
            xlabel(sr)
            file2='Mass';
        else
            hist(Period(j,:),ceil(sum(~isnan(Period(j,:)))/20));
            sr = strcat('Period:',sr2(j),',Sample:',Pst{j});
            xlabel(sr)
            file2='Period';
        end
    end
    file=['APS_out\',file2,'.png'];
    print('-dpng',file)
end

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
for k=4:6
    figure('Name',num2str(k),'Visible','off')
    for j=1:3
        subplot(1,3,j)
        if k == 4
            hist(RadiusBoot(j,:),ceil(sum(~isnan(RadiusBoot(j,:)))/(10*Comp)));
            sr = strcat('Radius:',sr2(j),',Sample:',Rst{j});
            xlabel(sr)
            file2='BootStrappedRadii';
        elseif k == 5
            hist(MassBoot(j,:),ceil(sum(~isnan(MassBoot(j,:)))/(40*Comp)));
            sr = strcat('Mass:',sr2(j),',Sample:',Mst{j});
            xlabel(sr)
            file2='BootStrappedMass';
        else
            hist(PeriodBoot(j,:),ceil(sum(~isnan(PeriodBoot(j,:)))/(40*Comp)));
            sr = strcat('Period:',sr2(j),',Sample:',Pst{j});
            xlabel(sr)
            file2='BootStrappedPeriod';
        end
    end
    file=['APS_out\',file2,'.png'];
    print('-dpng',file)
end
        