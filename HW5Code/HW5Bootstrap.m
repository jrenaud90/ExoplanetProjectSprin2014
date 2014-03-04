clear all
file = load('mass.mat');
mass = file.Mass;
clear file
bootstrap = 5000;
%1988, 13 + 13 -> 2014
count1 = 1;
count2 = 1;
for i=1:length(mass(:,1))
    if mass(i,2) <= 2001
        MassFirst(count1) = mass(i,1);
        count1 = count1 +1;
    else
        MassSec(count2) = mass(i,1);
        count2 = count2 +1;
    end
end
clear count1 count2 i
%Bootstrapping
FirstHalfMassMeans = BootstrapM2(MassFirst,bootstrap);
SecHalfMassMeans = BootstrapM2(MassSec,bootstrap);
figure(2)
hist(FirstHalfMassMeans,DoanesBins(FirstHalfMassMeans,1));
 hold on;
 hist(SecHalfMassMeans,DoanesBins(SecHalfMassMeans,1));
h = findobj(gca,'Type','patch');
set(h(1),'FaceColor','r','EdgeColor','k');
set(h(2),'FaceColor','b','EdgeColor','k');