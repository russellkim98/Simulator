% The main file for simulating aspects of an auction bid based on previous
% In case we want to simulate more than one truth 
global counter; 
counter = 1; 
% labels = csvread('ParsedParam.csv',0,0,    
% Read in data
global data;  
data = csvread('ParsedParam.csv',1,0);   % DH: this reads in all data from the csv (header is not read in)


% % Read in the ad number, the csv file
% campaign_Number = input('Enter the campaign number.'); 
% ad_id = input('Enter the ad number.'); 
% year = input('Enter the last two digits of the year.'); 
% month = input('Enter the month number'); 
% day = input('Enter the day.'); 
% day_of_week = input('Enter the day of week as a number.'); 
% hour = input('Enter the hour of day.');
% bid = input('Enter the bid number'); 

% Use this for debugging purposes 
campaign_id = 188942304; 
ad_group_id = 14728045224; 
global test_year; 
test_year = 16; 
global test_month; 
test_month = 2; 
global test_day; 
test_day = 5; 
global test_day_of_week; 
test_day_of_week = 4; 
global test_hour; 
test_hour = 10; 
% global bid; 
% bid = to_be_determined

%Get the height of the array so that we can iterate through them
global column_No; 
column_No = size(data,1);
% Keep track of the number of data points in each ad group
number_of_data_Points = 0;  

% Keep track of all the data so it can be simulated
number_of_auctions = 0; 
cost_per_click = 0;
number_of_clicks = 0; 
value_of_clicks = 0; 

% Aggregate the sums of all the data points 
for x = 1:(column_No)
    if data(x,2) == ad_group_id 
        number_of_data_Points = number_of_data_Points + 1;
        number_of_auctions = number_of_auctions + data(x,5);
        cost_per_click = cost_per_click + data(x, 17);
        number_of_clicks = number_of_clicks + data(x,7); 
        value_of_clicks = value_of_clicks + data(x,19);
    end 
%     if all(data(x,2) == ad_Number ,data(x,3) == year ,data(x,4) == month ,data(x,5) == day ,data(x,6) == day_of_week ,data(x,7) == hour_of_day)
%         number_of_data_Points = number_of_data_Points + 1;
%         number_of_auctions = number_of_auctions + data(x,5);
%         cost_per_click = cost_per_click + data(x, 17);
%         number_of_clicks = number_of_clicks + data(x,7); 
%         value_of_clicks = value_of_clicks + data(x,19);
%     end 
end  

% Calculate the averages of the values 
avg_num_auctions = number_of_auctions/number_of_data_Points;  
avg_cpc = cost_per_click/number_of_data_Points;
avg_num_clicks = number_of_clicks/number_of_data_Points; 
avg_value_clicks = value_of_clicks/number_of_data_Points; 


% Simulate the number of auctions 
sim_Auctions = simAuctions(avg_num_auctions)
% Simulate the number of impressions
sim_Impressions = simImpressions(sim_Auctions)
% Simulate the number of clicks
sim_Clicks = simClicks(sim_Auctions)
% Simulate the number of conversions
sim_Conversions = simConversions(sim_Clicks)
% Simulate the total cost
sim_total_Cost = totalCost(avg_num_clicks,avg_cpc)
% Simulate the total revenue 
sim_total_Revenue = totalRevenue(avg_value_clicks,avg_num_clicks)


% % Export it to a csv file 
% labels = {'campaign_id'	'ad_group_id' 'year' 'month' 'day-of-week' 'hour_of_day'	'auctions' 'impressions' 'clicks' 'conversions' 'total_Cost' 'total_Revenue'}; 
% [rows,cols]=size(labels);
% fid=fopen('sim_Output.csv','wt');
% for i=1:rows
%       fprintf(fid,'%s,',labels{i,1:end-1});
%       fprintf(fid,'%s\n',labels{i,end});
% end
% 
% 
% 
% fclose(fid);


sim_Data = [campaign_id ad_group_id   test_year   test_month	 test_day_of_week   test_hour	 sim_Auctions   sim_Impressions   sim_Clicks   sim_Conversions   sim_total_Cost   sim_total_Revenue]; 
writeToCsv(sim_Data) 
