
clear all
%Sin(i)
precision=0.0001; %Smaller better
x = 0:precision:pi()/2;
comp = 100000;
comp2 = 50;
comp3 = 10000;
ranset = zeros(comp,1);
l0 = length(x);
for i = 1:comp
    r = randi(l0);
    ranset(i,1)=sin(x(r));
end

l1 = length(ranset);
testmass = 10;
testmasses = zeros(comp2,1);
for i = 1:comp2
    r = randi(l1);
    testmasses(i,1) = testmass/ranset(r);
end
res = BootstrapMn(testmasses,comp3);
hist(res,10)