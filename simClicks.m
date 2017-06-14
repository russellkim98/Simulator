function[simulated_num_clicks] = simClicks(data,number_of_Auctions,column_No, year1, month1, day1, day_of_week1, hour1, sim_Auctions) 

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
% Transpose to make them column vectors 
year = year'; 
month = month'; 
day = day';
day_of_week = day_of_week'; 
hour = hour';
auctions = auctions';
clicks = clicks';

% Create the vectors for entry into regression 
x = [year month day day_of_week hour];
y = [clicks auctions]; 

% If # of clicks > # of auctions, edit values so that 
% # of clicks = # of auctions
for a = 1:column_No 
    if all(y(a,1) > y(a,2))
        y(a,1) = y(a,2);
    end 
end 
% Perform logistical regression and find predicted values 
logitCoef = glmfit(x,[y],'binomial');

% In here, define a new vector that is the "test" variable
% so we can control what dates, bid price, etc 
%
%
%
%
%
testingData = [15 3 30 0 13]; 
pWC = glmval(logitCoef, testingData, 'logit'); 


simulated_num_clicks = binornd(sim_Auctions,pWC); 

% STILL IN DEVELOPMENT 
% tester = [year1 month1 day1 day_of_week1 hour1 600000];
% model = training_Phase(data,column_No); 
% 
% simulated_num_clicks = predict(model,tester); 
