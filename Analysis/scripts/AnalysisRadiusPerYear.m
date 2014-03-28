clear all
file = input('File name: ','s');
if isempty(file)
    file = 'planets_Mass_Radius_Year_Distvalues.csv';
end
[FullDataJ,FullDataE] = Data2YMD(file);
comp = 100;
l = length(FullDataE);

years = min(FullDataE(:,10)):1:max(FullDataE(:,10));
radius(:,1) = years;
radius(:,2:758) = NaN;
for i = 1:l
    indx = find(radius(:,1)==FullDataE(i,10));
    indx2 = sum(~isnan(radius(indx,:)))+1;
    radius(indx,indx2)=FullDataE(i,4);
end
count = 1;
count2=1;
for k = 10:16
for i=2:758
    for j=1:k
        if ~isnan(radius(j,i))
            radtot{count2}(1,count)=radius(j,i);
            count = count +1;
        end
    end
end
count = 1;
count2=count2+1;
end
for j=1:7
    figure(j)
    hist(radtot{j},40)
    xlabel('Radii (Earth Radius)')
    ylabel('Density')
    str=num2str(j+2007);
    strF=strcat('Year: ',str);
    title(strF)
end