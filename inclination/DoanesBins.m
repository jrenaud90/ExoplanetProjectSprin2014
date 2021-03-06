function [k] = DoanesBins(DataSet,round_qst)
% Doane DP (1976) Aesthetic frequency classi?cation. American Statistician, 30: 181�183
n = length(DataSet);
avg = mean(DataSet);
%  g_{1} is the estimated 3rd-moment-skewness
num = zeros(n,1);
for i=1:n
    num(i,1)= (DataSet(i) - avg)^3;
end
g_1 = (1/n)*(sum(num))/(std(DataSet))^3;
sigma_g1 = sqrt(6*(n-2)/((n+1)*(n+3)));
k_un = 1 + log2(n)+log2(1+((abs(g_1))/sigma_g1));
if round_qst == 1
    k = ceil(k_un);
elseif round_qst == 2
    k = floor(k_un);
else
    k = k_un;
end
end

