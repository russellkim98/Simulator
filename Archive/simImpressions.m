function[simulated_Impressions] = simImpressions(sim_Auctions)

global data; 
global column_No; 
global test_year; 
global test_month;  
global test_day; 
global test_day_of_week; 
global test_hour; 
% global bid; 
% Gather all data into a 2D array 
year = zeros([1 column_No]); 
month = zeros([1 column_No]); 
day = zeros([1 column_No]);  
day_of_week = zeros([1 column_No]); 
hour = zeros([1 column_No]); 
auctions = zeros([1 column_No]); 
impressions = zeros([1 column_No]); 
 
 
for x = 1:column_No
    year(x) = data(x,3);
    month(x) = data(x,4); 
    day(x) = data(x,5); 
    day_of_week(x) = data(x,6); 
    hour(x) = data(x,7); 
    auctions(x) = data(x,8); 
    impressions(x) = data(x,9); 

end 
% Transpose to make them column vectors 
year = year'; 
month = month'; 
day = day';
day_of_week = day_of_week'; 
hour = hour';
auctions = auctions';
impressions = impressions';

% Create the vectors for entry into regression 
x = [year month day day_of_week hour auctions];
y = [impressions auctions]; 

% If # of impressions > # of auctions, edit values so that 
% # of impressions = # of auctions
for a = 1:column_No 
    if all(y(a,1) > y(a,2))
        y(a,1) = y(a,2);
    end 
end 
% Perform logistical regression and find predicted values 
logitCoefImp = glmfit(x,[y],'binomial');

% In here, define a new vector that is the "test" variable
% so we can control what dates, bid price, etc 

testingData = [test_year test_month test_day test_day_of_week test_hour sim_Auctions]; 
pWC = glmval(logitCoefImp, testingData, 'logit'); 


simulated_Impressions = binornd(sim_Auctions,pWC); 
