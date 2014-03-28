clear all
file = input('File name: ','s');
if isempty(file)
    file = 'planets_Mass_Radius_Year_Distvalues.csv';
end
[FullDataJ,FullDataE] = Data2YMD(file);
comp = 100;
l = length(FullDataE);

%%Find the distribution of medians for each year
yearspan = min(FullDataE(:,10)):1:max(FullDataE(:,10));
years = length(yearspan);
DistPerYear(:,1) = yearspan;
MassPerYear(:,1) = yearspan;
RadiusPerYear(:,1) = yearspan;
count = 2;
for i=1:l
    yr = FullDataE(i,10);
    indx = find(yearspan==yr);
    if FullDataE(i,1) > 0
        MassPerYear(indx,count) = FullDataE(i,1);
    else
        MassPerYear(indx,count) = NaN;
    end
    if FullDataE(i,4) > 0
        RadiusPerYear(indx,count) = FullDataE(i,4);
    else
        RadiusPerYear(indx,count) = NaN;
    end
    if FullDataE(i,7) > 0
        DistPerYear(indx,count) = FullDataE(i,7);
    end
    count = count + 1;
end
MassPerYear = sort(MassPerYear,2);
RadiusPerYear = sort(RadiusPerYear,2);
DistPerYear = sort(DistPerYear(:,2:1137),2);
x_1(:,1) = yearspan;
x_2(:,1) = yearspan;
x_3(:,1) = yearspan;
for j = 1:years
    mtest = find(MassPerYear(j,:));
    rtest = find(RadiusPerYear(j,:));
    dtest = find(DistPerYear(j,:));
    mtl = length(mtest);
    rtl = length(rtest);
    dtl = length(dtest);
    if mtl == 1
        m_l_mean = NaN;
        m_u_mean = NaN;
    elseif mtl == 2
        m_l_mean = MassPerYear(j,mtest(1));
        m_u_mean = m_l_mean;
    elseif mtl == 3
        m_l_mean = MassPerYear(j,mtest(1));
        m_u_mean = MassPerYear(j,mtest(2));
    elseif mtl == 4
        m_l_mean = MassPerYear(j,mtest(1));
        m_u_mean = MassPerYear(j,mtest(3)); 
    elseif mtl == 5
        m_l_mean = mean([MassPerYear(j,mtest(1)),MassPerYear(j,mtest(2))]);
        m_u_mean = mean([MassPerYear(j,mtest(3)),MassPerYear(j,mtest(4))]);
    else
        t = mtl;
        m_l_mean = mean([MassPerYear(j,mtest(1)),MassPerYear(j,mtest(2))...
            ,MassPerYear(j,mtest(3))]);
        m_u_mean = mean([MassPerYear(j,mtest(t-3)),MassPerYear(j,mtest(t-2))...
            ,MassPerYear(j,mtest(t-1))]);
    end
    if rtl == 1
        r_l_mean = NaN;
        r_u_mean = NaN;
    elseif rtl == 2
        r_l_mean = RadiusPerYear(j,rtest(1));
        r_u_mean = r_l_mean;
    elseif rtl == 3
        r_l_mean = RadiusPerYear(j,rtest(1));
        r_u_mean = RadiusPerYear(j,rtest(2));
    elseif rtl == 4
        r_l_mean = RadiusPerYear(j,rtest(1));
        r_u_mean = RadiusPerYear(j,rtest(3)); 
    elseif rtl == 5
        r_l_mean = mean([RadiusPerYear(j,rtest(1)),RadiusPerYear(j,rtest(2))]);
        r_u_mean = mean([RadiusPerYear(j,rtest(3)),RadiusPerYear(j,rtest(4))]);
    else
        t = rtl;
        r_l_mean = mean([RadiusPerYear(j,rtest(1)),RadiusPerYear(j,rtest(2))]);
        r_u_mean = mean([RadiusPerYear(j,rtest(t-2)),RadiusPerYear(j,rtest(t-1))]);
    end
    if dtl == 1
        d_l_mean = NaN;
        d_u_mean = NaN;
    elseif dtl == 2
        d_l_mean = DistPerYear(j,dtest(1));
        d_u_mean = d_l_mean;
    elseif mtl == 3
        d_l_mean = DistPerYear(j,dtest(1));
        d_u_mean = DistPerYear(j,dtest(2));
    elseif dtl == 4
        d_l_mean = DistPerYear(j,dtest(1));
        d_u_mean = DistPerYear(j,dtest(3)); 
    elseif dtl == 5
        d_l_mean = mean([DistPerYear(j,dtest(1)),DistPerYear(j,dtest(2))]);
        d_u_mean = mean([DistPerYear(j,dtest(3)),DistPerYear(j,dtest(4))]);
    else
        t = dtl;
        d_l_mean = mean([DistPerYear(j,dtest(1)),DistPerYear(j,dtest(2))]);
        d_u_mean = mean([DistPerYear(j,dtest(t-2)),DistPerYear(j,dtest(t-1))]);
    end
    x_1(j,2)=r_l_mean*d_u_mean;
    x_2(j,2)=r_l_mean/d_u_mean;
    x_3(j,2)=d_u_mean/r_l_mean;
end
    
%{

clear years yearspan massind masses l indexs i file count2 count MassMedYear MassMed DistMn DistMnNum DistMnYear MassMedNum dists disstind count3 
save('DataOutput_Analysis.mat','DataMean')
%}

