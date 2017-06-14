function[Mdl1] = training_Phase(data, column_No) 
% STILL IN DEVELOPMENT
% THIS FILE NOT IN USE 

% Gather all data into a 2D array 
year = []; 
month = []; 
day = []; 
day_of_week = []; 
hour = [];  
auctions = []; 
clicks = []; 
 

for x = 1:column_No
    year = [year data(x,3)];
    month = [month data(x,4)]; 
    day = [day data(x,5)]; 
    day_of_week = [day_of_week data(x,6)]; 
    hour = [hour data(x,7)]; 
    auctions = [auctions data(x,8)]; 
    clicks = [clicks data(x,10)]; 

end 

year = year'; 
month = month'; 
day = day';
day_of_week = day_of_week'; 
hour = hour';
auctions = auctions';
clicks = clicks';




Tbl = table(year,month,day,day_of_week,hour,auctions,clicks);

% Specify a regression tree template that uses surrogate splits to impove
% predictive accuracy in the presence of |NaN| values
tree = templateTree('Surrogate', 'On'); 

% Train the regression ensemble using LSBoost and using 500 cycles
Mdl1 = fitensemble(Tbl,'clicks','LSBoost',500,'Tree'); 

