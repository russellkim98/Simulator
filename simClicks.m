function[simulated_num_clicks] = simClicks(sim_Auctions) 

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
clicks = zeros([1 column_No]);  
 
 
for x = 1:column_No
    year(x) = data(x,3);
    month(x) = data(x,4); 
    day(x) = data(x,5); 
    day_of_week(x) = data(x,6); 
    hour(x) = data(x,7); 
    auctions(x) = data(x,8); 
    clicks(x) = data(x,10); 

end 
% Transpose to make them column vectors 
year = year'; 
month = month'; 
day = day';
day_of_week = day_of_week'; 
hour = hour';
auctions = auctions';
clicks = clicks';

% Create the vectors for entry into regression 
x = [year month day day_of_week hour auctions];
y = [clicks auctions]; 

% If # of clicks > # of auctions, edit values so that 
% # of clicks = # of auctions
for a = 1:column_No 
    if all(y(a,1) > y(a,2))
        y(a,1) = y(a,2);
    end 
end 
% Perform logistical regression and find predicted values 
logitCoefClicks = glmfit(x,[y],'binomial');

% In here, define a new vector that is the "test" variable
% so we can control what dates, bid price, etc 

testingData = [test_year test_month test_day test_day_of_week test_hour sim_Auctions]; 
pWC = glmval(logitCoefClicks, testingData, 'logit'); 


simulated_num_clicks = binornd(sim_Auctions,pWC); 

% STILL IN DEVELOPMENT 
% tester = [year1 month1 day1 day_of_week1 hour1 600000];
% model = training_Phase(data,column_No); 
% 
% simulated_num_clicks = predict(model,tester); 
