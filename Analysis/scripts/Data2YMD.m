function [FullDataJ,FullDataE] = Data2YMD(filename)
data = load(filename);
lint = length(data(:,1));
jtoeMass = 317.828133;
jtoeRadius = 10.95097118;
count = 1;
for i = 1:lint
    if data(i,4)>0||data(i,4)==0
        datared(count,1:10) = data(i,1:10);
        count = count +1;
    end
end
Exoplanets = length(datared);
FullDataJ = datared;
%%Converting Jupiter Masses to Earth Masses.
FullDataE = zeros(Exoplanets,3);
for i = 1:Exoplanets
    FullDataE(i,1) = jtoeMass*FullDataJ(i,1);
    FullDataE(i,2) = jtoeMass*FullDataJ(i,2);
    FullDataE(i,3) = jtoeMass*FullDataJ(i,3);
    FullDataE(i,4) = jtoeRadius*FullDataJ(i,4);
    FullDataE(i,5) = jtoeRadius*FullDataJ(i,5);
    FullDataE(i,6) = jtoeRadius*FullDataJ(i,6);
    FullDataE(i,7:10) = FullDataJ(i,7:10);
end

end

    
