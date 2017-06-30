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
global ad_group_id; 
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

% Initialize the policy 
[X,theta,p] = initialize_KG();

% Clean up data 
auctions = data_preprocessor(); 
profit = 0; 

 % Start parallel processing
%parpool

% Loop for every hour in the week 
% Simulate number of auctions in that hour, find out how many clicks there 
% are, then update the learning policy with the number of clicks/auctions
% based on the bid price
for i = 1:168
    % Get bid from policy 
    [X,theta,p,bid] = KG_hr(X,theta,p); 
    sampleAuctions = simAuctions(auctions(i)); 
    totalClicks = 0; 
    
    theta1 = theta(1,5);
    theta2 = theta(2,5); 
    for j = 1:sampleAuctions 
        clicks = Clicks(theta0,theta1,bid); 
        totalClicks = totalClicks + clicks;
    end 
    % Update learning policy 
    [X,theta,p] = learner_KG_hr(X,theta,p,bid,sampleAuctions,totalClicks);
    disp('test successful')
    for col=1:length(theta)
        bids = theta(:,col); 
        y = 1./(1 + exp(-bids(1) - bids(2) * x));
        if bids(1) == theta1 && bids(2) == theta2
            plot(x,y,'-.r*')
            drawnow
            pause(0.5)
        end
        if p(col) > 0.1 
            plot(x,y,'LineWidth',30*p(col)); 
            drawnow
            pause(0.5);
        end 
        
        hold on
    end
    p
    profit = profit + (20 - bid);
end 
% Stop parallel processing 
profile = gcp; 
delete(profile)
         
p
clicks 
profit
        
        








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


% sim_Data = [campaign_id ad_group_id   test_year   test_month	 test_day_of_week   test_hour	 sim_Auctions   sim_Impressions   sim_Clicks   sim_Conversions   sim_total_Cost   sim_total_Revenue]; 
% writeToCsv(sim_Data) 