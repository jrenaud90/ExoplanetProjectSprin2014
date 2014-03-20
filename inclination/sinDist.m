clear all
x = .4:.1:1;
y = sqrt(1-x.^2);
G(1:length(x),1) = x;
G(1:length(y),2) = y;