% The main file for simulating other 

data = csvread('output.csv',1,0);   % DH: this reads in all data from the csv (header is not read in)
% DH: output.csv is created by using 

%Read in the ad number, the csv file
prompt = 'Enter the ad number.'; 
ad_Number = input(prompt);   



ad_group_ids = csvread('output.csv',1,1,[1,1,71000,1]); 

data = csvread('param.csv',1, 3); 

%Get the height of the array so that we can iterate through them
column_No = size(data, 0); 
% Keep track of the number of data points in each ad group
number_of_data_Points = 0;  

% Keep track of all the data so it can be simulated
number_of_auctions = 0; 
cost_per_click = 0;
number_of_clicks = 0; 
value_of_clicks = 0; 

for x = 2:column_No
    if data(x,2) == ad_Number
        number_of_data_Points = number_of_data_Points + 1;
        number_of_auctions = number_of_auctions + data(x,5);
        cost_per_click = cost_per_click + data(x, 17);
        number_of_clicks = number_of_clicks + data(x,7); 
        value_of_clicks = value_of_clicks + data(x,19);
    end 
end 

% Calculate the averages of the values 
avg_num_auctions = number_of_auctions/number_of_data_Points; 
avg_cpc = cost_per_click/number_of_data_Points; 
avg_num_clicks = number_of_clicks/number_of_data_Points; 
avg_value_clicks = value_of_clicks/number_of_data_Points; 

% Simulate the number of auctions 


        
        