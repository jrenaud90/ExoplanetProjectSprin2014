l = length(rowid);
data_5sig = [rowid,tce_prad,flag];
data_10sig = [rowid,tce_prad,flag];
count = 0;
maxsize = 35;
for i = 1:l
    indx = i - count;
    if data_5sig(indx,3)>1
        data_5sig(indx,:) = [];
        count = count + 1;
    elseif data_5sig(indx,2)>maxsize
        data_5sig(indx,:) = [];
        count = count + 1;
    end
end
count = 0;
for i = 1:l
    indx = i - count;
    if data_10sig(indx,3)>1
        data_10sig(indx,:) = [];
        count = count + 1;
    elseif data_10sig(indx,2)>maxsize
        data_10sig(indx,:) = [];
        count = count + 1;
    end
end

figure(1)
hist(data_5sig(:,2),1000)
title('5sig')

figure(2)
hist(data_10sig(:,2),1000)
title('10sig')