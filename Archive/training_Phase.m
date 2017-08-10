function[Mdl1] = training_Phase(data, column_No) 
% STILL IN DEVELOPMENT
% THIS FILE NOT IN USE 

% Gather all data into a 2D array 
year = zeros(column_No); 
month = zeros(column_No); 
day = zeros(column_No); 
day_of_week = zeros(column_No);  
hour = zeros(column_No);  
auctions = zeros(column_No);  
clicks = zeros(column_No);  
 

for x = 1:column_No
    year(x) = data(x,3);
    month(x) = data(x,4); 
    day(x) = data(x,5); 
    day_of_week(x) = data(x,6); 
    hour(x) = data(x,7); 
    auctions(x) = data(x,8); 
    clicks(x) = data(x,10); 

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

