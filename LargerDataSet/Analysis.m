clear all
file = input('File name: ','s');
if isempty(file)
    file = 'planets3_17_14Reduced.csv';
end
[Y_JM_D,Y_EM_D] = Data2YMD(file);
comp = 100;

%%Find the distribution of medians for each year
yearspan = min(Y_EM_D(:,1)):1:max(Y_EM_D(:,1));
years = length(yearspan);
count = 1;
for i =yearspan
    indexs = find(Y_EM_D(:,1)==i);
    count2 = 1;
    clear masses
    if ~isempty(indexs)
    for j = transpose(indexs)
        masses(count2,1) = Y_EM_D(j,2);
        count2 = count2+1;
    end
    MassMed(count,:) = BootstrapMed(masses,comp);
    MassMedYear(count,1) = i;
    MassMedNum(count,1) = length(transpose(indexs));
    count = count + 1;
    end
end
for i=1:length(MassMedYear(:,1))
    Masss(i,1)=MassMedYear(i,1);
    Masss(i,2)=MassMedNum(i,1);
    Masss(i,3:comp+2)=MassMed(i,1:comp);
end

clear i j
%%Find Means of distances per year.
count = 1;
for i =yearspan
    %%Since there are some NaN items in the distance column, we need to be
    %%more careful.
    indexs = find(Y_EM_D(:,1)==i);
    count2 = 0;
    count3 = 0;
    clear dists
    if ~isempty(indexs)
    for j = transpose(indexs)
        if Y_EM_D(j,4) > 0
            count2 = count2+1;
            count3 = count3 + 1;
            dists(count2,1) = Y_EM_D(j,4);
        else
            count3 = count3 + 1;
        end
    end
    if count2 > 0
    DistMed(count,:) = BootstrapMed(dists,comp);
    DistMedYear(count,1) = i;
    DistMedNum(count,1) = count2;
    count = count + 1;
    end
    end
end
for i=1:length(DistMedYear(:,1))
    Distss(i,1)=DistMedYear(i,1);
    Distss(i,2)=DistMedNum(i,1);
    Distss(i,3:comp+2)=DistMed(i,1:comp);
end
clear i j
%%Find Means of the medians per year, with the std.
l = length(yearspan);
DataMean = NaN*ones(l,7);
count = 1;
for i = yearspan
    DataMean(count,1) = i;
    if ~isempty(find(Masss(:,1)==i))
        massind = find(Masss(:,1)==i);
        DataMean(count,2) = mean(Masss(massind,3:comp+2));
        DataMean(count,3) = std(Masss(massind,3:comp+2));
        DataMean(count,4) = Masss(massind,2);
    end
    if ~isempty(find(Distss(:,1)==i))
        disstind = find(Distss(:,1)==i);
        DataMean(count,5) = mean(Distss(disstind,3:comp+2));
        DataMean(count,6) = std(Distss(disstind,3:comp+2));
        DataMean(count,7) = Distss(disstind,2);
    end
    count = count + 1;
end
clear years yearspan massind masses l indexs i file count2 count MassMedYear MassMed DistMn DistMnNum DistMnYear MassMedNum dists disstind count3 
save('DataOutput_Analysis.mat','DataMean')

