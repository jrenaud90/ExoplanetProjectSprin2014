function OutputData1 = BootstrapMn(InputData,CompLength)
%Bootstrap Method 1
rng('shuffle');
mn = zeros(CompLength,1);
l = length(InputData);
for i=1:CompLength
    k = 1;
    BootstrapData = zeros(length(InputData),1);
    while k <= l
        %RandomSample With Replacement
        r = randi([1 l],1,1);
        BootstrapData(k,1) = InputData(r);
        k = k +1;
    end
    mn(i) = mean(BootstrapData);
end
OutputData1 = mn;
end