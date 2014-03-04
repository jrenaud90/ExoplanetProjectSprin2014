clear all
data = load('dat.csv'); %Exoplanets.org, Masses are in J-mass, radius are in J-radius.
l = length(data(:,1));
%%Data Reduction part 1
%%%Grabing data and placing in new series that are represnetative of the
%%%data types.
count = 1;
for i =1:l
    if data(i,2) >= 0
        Mass(count,1:2) = data(i,2:3);
        count = count+1;
    end
end
count = 1;
for i =1:l
    if data(i,1) >= 0
        Radius(count,1:2) = data(i,1:2:3);
        count = count+1;
    end
end
count = 1;
    %Construct Year List
    Years(:,1) = min(data(:,3)):1:max(data(:,3));
    Years(:,2) = 0;
    Yearslist = Years;
for i =1:l
    if data(i,4) >= 0
        index = find(Years(:,1)==data(i,3));
        Years(index,2) = Years(index,2) + data(i,4);
    end
end
clear count
%%Furthur reduction
%%%Average Mass per year
AvgMassSum = Yearslist;
AvgMassSum(:,3) = 0;
for i = 1:length(Mass(:,1))
    index = find(AvgMassSum(:,1)==Mass(i,2));
    AvgMassSum(index,2) = AvgMassSum(index,2) + Mass(i,1);
    AvgMassSum(index,3) = AvgMassSum(index,3) + 1;
end
for i = 1:length(AvgMassSum(:,1))
    AvgMass(i,1) = AvgMassSum(i,1);
    AvgMass(i,2) = AvgMassSum(i,2)/AvgMassSum(i,3);
end
%%%Average radius per year
AvgRadSum = Yearslist;
AvgRadSum(:,3) = 0;
for i = 1:length(Radius(:,1))
    index = find(AvgRadSum(:,1)==Radius(i,2));
    AvgRadSum(index,2) = AvgRadSum(index,2) + Radius(i,1);
    AvgRadSum(index,3) = AvgRadSum(index,3) + 1;
end
for i = 1:length(AvgRadSum(:,1))
    AvgRadd(i,1) = AvgRadSum(i,1);
    AvgRadd(i,2) = AvgRadSum(i,2)/AvgRadSum(i,3);
end
count = 1;
for i = 1:length(AvgRadd(:,1))
    if AvgRadd(i,2) > 0
        AvgRad(count,1) = AvgRadd(i,1);
        AvgRad(count,2) = AvgRadd(i,2);
        count = count + 1;
    end
end

clear i AvgMassSum count AvgRadSum Yearslist index l
figure(1)
subplot(1,2,1)
semilogy(Mass(:,2),Mass(:,1),'.')
xlabel('Year of Publication')
ylabel('Planet Minimum Mass (Log Jupiter Mass)')
title('Exoplanet Mass vs. Pub. year')
subplot(1,2,2)
semilogy(AvgMass(:,1),AvgMass(:,2),'.')
xlabel('Year of Publication')
ylabel('Planets year-Average Minimum Mass (Log Jupiter Mass)')
title('Exoplanet year-averaged Min.Mass vs. Pub. year')

figure(2)
subplot(1,2,1)
semilogy(Radius(:,2),Radius(:,1),'.')
xlabel('Year of Publication')
ylabel('Planet Radius (Log Jupiter Radius)')
title('Exoplanet Mass vs. Pub. year')
subplot(1,2,2)
semilogy(AvgRad(:,1),AvgRad(:,2),'.')
xlabel('Year of Publication')
ylabel('Planets year-Average Radius (Log Jupiter Radius)')
title('Exoplanet year-Averaged Radius vs. Pub. year')

