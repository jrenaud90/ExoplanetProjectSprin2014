function [YearJMassDist,YearEMassDist] = Data2YMD(filename)
data = load(filename);
lint = length(data(:,1));
datared = zeros(lint,length(data(1,:))-1);
jtoeMass = 317.828133;
for i = 1:lint
    datared(i,1:length(data(1,:))-1) = data(i,2:length(data(1,:)));
end
count = 1;
for i = 1:lint
    if datared(i,1)>0||datared(i,1)==0
        datared2(count,1:4) = datared(i,1:4);
        count = count +1;
    elseif datared(i,2)>0||datared(i,2)==0
        datared2(count,1:4) = datared(i,1:4);
        count = count +1;
    end
end
Exoplanets = length(datared2);
count = 1;
for i = 1:Exoplanets
    YearJMassDist(count,1) = datared2(i,4);
    YearJMassDist(count,4) = datared2(i,3);
    if datared2(i,1)>0||datared2(i,1)==0
        YearJMassDist(count,2) = datared2(i,1);
        count = count +1;
    else
        minmass = datared2(i,2);
        %%This is where I will insert minmass conversion to regular mass.
        %%This will be based upon the distribution of sin(i) for random i.
        %%The probability that sin(i)>x is P = Sqrt(1-x^2), so Sin(i)>0.5
        %%has P = about 87%
        %%
        %%
        %%Default:
         %%%For now assume that M = [m*sin(i)]
         [mass,stdd] = SinIDist(minmass);
        YearJMassDist(count,2) = mass;
        YearJMassDist(count,3) = stdd;
        count = count + 1;
    end
end
%%Converting Jupiter Masses to Earth Masses.
YearEMassDist = zeros(Exoplanets,3);
for i = 1:Exoplanets
    YearEMassDist(i,1) = YearJMassDist(i,1);
    YearEMassDist(i,4) = YearJMassDist(i,4);
    YearEMassDist(i,3) = jtoeMass*YearJMassDist(i,3);
    YearEMassDist(i,2) = jtoeMass*YearJMassDist(i,2);
end

end

function [mass,stdd] = SinIDist(MassSini)
%Uses distribution of sini function to give an estimate on mass.

%for now we will just return mass*sin(i)
mass = MassSini;
stdd = 0;


end

    
