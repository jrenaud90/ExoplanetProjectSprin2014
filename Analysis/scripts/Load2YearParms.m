function [ output_args ] = Load2YearParms(filename,Parm)
%Loads $filename and outputs vector(s) which are 
Data = load(filename);
Parms = length(Data(1,:));
if Parm ~= Parms
    error('Ensure Parms are correct.');
end

yrs = Data(:,1);
l = length(yrs);
years = min(yrs):1:max(yrs);
for i = years
    k = find(yrs==i);
    for j = k
        
    end
end
    
    
    


        
savestring = datestr(now);


end

