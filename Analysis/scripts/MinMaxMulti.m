function [OutputVector] = MinMaxMulti(Vector,MinMax,Number,IgnLarge)
%Function finds the $number minimum or maximum values of $vector. With the
%option of ignoring zeros. 
sz = size(Vector);
if sz(1) > 1 && sz(2) > 1
    error('Input Data Must Be A Vector, Not A Matrix');
end
l = length(Vector);
if Number > l
    if IgnLarge == 1
        Number = l;
    else
    error('Size larger than vector length');
    end
end
if MinMax(2) == 'i'
    minmax = 1;
else
    minmax = 2;
end
holder1 = zeros(Number,1);
count = 1;
if minmax == 1
    for i = 1:Number
        mn = min(Vector);
        if mn == 0
            indx = find(Vector==mn);
        else
            holder1(count)=mn;
            indx = find(Vector==mn);
            count = count + 1;
        end
        Vector = [Vector(1:indx-1),Vector(indx+1:l)];
        l = l -1;
    end
elseif minmax == 2
    for i = 1:Number
        holder1(count)=max(Vector);
        indx = find(Vector==holder1(count));
        Vector = [Vector(1:indx-1),Vector(indx+1:l)];
        count = count + 1;
        l = l -1;
    end
end
OutputVector = holder1;
end

