clear all
%KOI Analysis

%%Read in Data
%  One file is confirmed exoplanets so that the KOI file does not have
%  repeats. 
Confirmed = ReadIn('confirmed2.txt');
koi = ReadIn('KOI4-9-14Red.txt',2,7287,'%f%s%f%[^\n\r]');
koi_data = [koi{1},koi{3}];

%%Only interested in a list of names of the confirmed exoplanets.
conf_names = Confirmed{3};
conf_l = length(conf_names);
conf_namesReduced = {};
for i = 1:conf_l %Clean them up.
    testname = conf_names{i};
    testname(ismember(testname,' ,.:;!-')) = [];%Gets rid of these characters.
    conf_namesReduced{i,1} = lower(testname); %Lowercases the string.
    clear testname
end

%%Clean up names of KOI planets.
koi_names = koi{2};
koi_l1 = length(koi_names);
koi_namesReduced = {};
for i = 1:koi_l1 %Clean them up.
    testname = koi_names{i};
    testname(ismember(testname,' ,.:;!-')) = [];%Gets rid of these characters.
    koi_namesReduced{i,1} = lower(testname); %Lowercases the string.
    clear testname
end

%%Check if any items in koi are in the confirmed list
duplicates = 0;
%Check for duplicates in the two datasets. 
test = ismember(koi_namesReduced,conf_namesReduced);
t = sum(test);
if t > 0
    %Get rid of duplicates from KOI data.
    for i = 1:t
        koi_data(i+duplicates,:) = [];
        duplicates = duplicates + 1;
    end        
else
    duplicates = 0;
end

%%
% *Analysis Begins*
l = length(koi_data(:,1));
max_radius = 35; %Earth Radii
count = 0;
toolarge = find(koi_data(:,2)>max_radius);
koi_dataSM = koi_data;
count = 0;
for i = 1:length(toolarge)
    koi_dataSM(toolarge(i)-count,:) = [];
    count = count +1;
end

figure(1)
hist(Confirmed{1,2},100)
title('Confirmed Planets')
xlabel('Radius (Earth Radii)')


figure(2)
hist(koi_dataSM(:,2),300)
title('KOI Planets')
xlabel('Radius (Earth Radii)')
figure(3)
hist(koi_dataSM(:,2),300)
axis([0 35 0 150])
title('KOI Planets')
xlabel('Radius (Earth Radii)')



