clear all
load('DataOutput_Analysis.mat');
count = 1;
for i = 1:length(DataMean(:,1))
    if DataMean(i,2) > 0
    DataPrime(count,:)=DataMean(i,:);
    count = count + 1;
    end
end
clear i count
count = 1;
for i = 1:length(DataPrime(:,1))
    if DataPrime(i,5) > 0
        DataDist(count,:)=DataPrime(i,:);
        count = count + 1;
    end
end
DataDist2=DataDist(2:21,:);
file = 'planets3_17_14Reduced.csv';
[Y_JM_D,Y_EM_D] = Data2YMD(file);

clear i count
figure(1)
subplot(1,2,2)
errorbar(DataDist2(:,1),DataDist2(:,2),DataDist2(:,3),'.b')
xlabel('Year of Discovery')
ylabel('Bootstrapped Median-Mass (Earth Masses)')
subplot(1,2,1)
semilogy(Y_EM_D(:,1),Y_EM_D(:,2),'.k')
xlabel('Year of Discovery')
ylabel('Exoplanet Masses (Earth Masses)')
%%Distances
figure(3)
subplot(1,2,2)
errorbar(DataDist2(:,1),DataDist2(:,5),DataDist2(:,6),'.r')
xlabel('Year of Discovery')
ylabel('Bootstrapped Median-Distances (Parsecs)')
subplot(1,2,1)
semilogy(Y_EM_D(:,1),Y_EM_D(:,4),'.k')
xlabel('Year of Discovery')
ylabel('Distance from Earth (Parsecs)')