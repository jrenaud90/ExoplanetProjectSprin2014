clear all
file = input('File name: ','s');
if isempty(file)
    file = 'KepExopRd2.csv';
end
data = load(file);
radius = data(:,1);
dist = data(:,2);
year = data(:,3);
flag = data(:,4);
l = length(radius);
rad_nokep = [];
rad_kep = [];
count1 = 1;
count2 = 2;
for i = 1:l
    if ~isnan(radius(i))
        if flag(i) == 1
            rad_kep(count1,1)=radius(i);
            rad_kep(count1,2)=year(i);
            rad_kep(count1,3)=dist(i);
            count1 = count1 +1;
        else
            rad_nokep(count2,1)=radius(i);
            rad_nokep(count2,2)=year(i);
            rad_nokep(count2,3)=dist(i);
            count2 = count2 +1;
        end
    end
end
l1=length(rad_kep(:,1));
l2=length(rad_nokep(:,1));
figure(1)
subplot(1,2,1)
hist(rad_kep(:,1),30)
xlabel('Kepler Radius (Earth Radii)')
subplot(1,2,2)
hist(rad_nokep(:,1),10)
axis([0 20 0 100])
xlabel('Non-Kepler Radius (Earth Radii)')

for i = 1:1000
    for j = 1:l1
        ind1 = randi(l1);
        newkepset(j) = rad_kep(ind1,1);
    end
    for j = 1:l2
        ind2 = randi(l2);
        newnonkepset(j) = rad_nokep(ind2,1);
    end
    statsKep(i,1) = mean(newkepset);
    statsKep(i,2) = std(newkepset);
    [statsKep(i,3),statsKep(i,4)] = ttest(newkepset,statsKep(i,1)); %h and p values
    statsNoKep(i,1) = mean(newnonkepset);
    statsNoKep(i,2) = std(newnonkepset);
    [statsNoKep(i,3),statsNoKep(i,4)] = ttest(newnonkepset,statsKep(i,1)); %h and p values 
end

figure(2)
subplot(1,2,1)
hist(statsKep(:,1))
xlabel('Kepler Radii Means')
subplot(1,2,2)
hist(statsNoKep(:,1))
xlabel('Non-Kepler Radii Means')


