function [OutputData1, OutputData2] = BootstrapM1(InputData,CompLength)
%Bootstrap Method 1
rng('shuffle');
Bias = zeros(CompLength,1);
UnBias = zeros(CompLength,1);
for i=1:CompLength
    k = 1;
    BootstrapData = zeros(length(InputData),1);
    while k <= length(InputData)
        %RandomSample With Replacement
        r = randi([1 length(InputData)],1,1);
        BootstrapData(k,1) = InputData(r);
        k = k +1;
    end
    UnBias(i,1) = std(BootstrapData,0);
    Bias(i,1) = std(BootstrapData,1);
end
OutputData1 = UnBias;
OutputData2 = Bias;
end

