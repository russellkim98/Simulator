function[simulated_num_clicks] = simClicks(data, column_No, year, month, day, day_of_week, hour) 

% %( 5x4 matrix(5 data points and 4 independent variables
% x = [avg_cpc 0 1 1; 2 6 3 6; 9 34 8 2; 86 3 4 6; 1 8 4 5];
% 
% % 5x2 matrix(5 data points and [number_of_clicks number_of_auctions]
% y = [number_of_clicks number_of_auctions; 3 number_of_auctions; 23 number_of_auctions; 112 number_of_auctions; 56 number_of_auctions]; 
%  
% x
% y
% logitCoef = glmfit(x,[y],'binomial'); 
% pWC = glmval(logitCoef, x, 'logit'); 
% 
% simulated_num_clicks = binornd(number_of_auctions,pWC); 

year = []; 
month = []; 
day = []; 
day_of_week = []; 
hour = []; 
auctions = []; 
clicks = []; 
conversions = []; 

for x = 1:column_No
    year = [year data(x,4)];
    month = [month data(x,5)]; 


end 