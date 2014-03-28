function [OutputVector] = MinMaxMulti(Vector,MinMax,Number,varargin)
%Function finds the $number minimum or maximum values of $vector. With the
%option of ignoring zeros. 
l = length(Vector);
zeros = varargin(1);

if MinMax(2) == 'i'
    minmax = 1;
else
    minmax = 2;
end
holder1 = zeros(Number,1);
if minmax == 1
    for i = 1:Number
        holder1(i)=min(Vector);
        Vector = [Vector(1:indx-1),Vector(indx+1:l)];
        l = l -1;
    end
elseif minmax == 2
    for i = 1:Number
        holder1(i)=max(Vector);
        Vector = [Vector(1:indx-1),Vector(indx+1:l)];
        l = l -1;
    end
end
    


end

