function OutputData1 = BootstrapMed(InputData,CompLength)
%Bootstrap Method 1
rng('shuffle');
mn = zeros(CompLength,1);
for i=1:CompLength
    k = 1;
    BootstrapData = zeros(length(InputData),1);
    while k <= length(InputData)
        %RandomSample With Replacement
        r = randi([1 length(InputData)],1,1);
        BootstrapData(k,1) = InputData(r);
        k = k +1;
    end
    mn(i) = median(BootstrapData);
end
OutputData1 = mn;
end