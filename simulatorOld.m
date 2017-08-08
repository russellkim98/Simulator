% The main file for simulating aspects of an auction bid based on previous
% In case we want to simulate more than one truth 
global counter; 
counter = 1; 
% labels = csvread('ParsedParam.csv',0,0,    
% Read in data
global data;  
data = csvread('ParsedParam.csv',1,0);   % DH: this reads in all data from the csv (header is not read in)
global column_No; 
column_No = 70176; 


% How to implement spatial attributes
% Assume that Country, region, city, etc will be columns in the csv files
% Treat like any other factor like year, month, day, etc 
% Same with day of week 
% For Different policies, just enter policy namne and pick the best bid 

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
[X1,theta1,p1] = initialize_KG();
[X2,theta2,p2] = initialize_KG();
[X3,theta3,p3] = initialize_KG();
% testrs = init(0.5); 

% Clean up data 
auctions = data_preprocessor(); 
profit = 0; 

a = [0, 1, 2, 3];
 % Start parallel processing
%parpool
x = 0:0.1:10;
% Loop for every hour in the week 
% Simulate number of auctions in that hour, find out how many clicks there 
% are, then update the learning policy with the number of clicks/auctions
% based on the bid price
truth_theta1_1 = -7;
truth_theta1_2 = 2;

totalClicks1 = 0; 
totalClicks2 = 0; 
totalClicks3 = 0; 

p_change_truth = csvread("parameters.csv", 0, 1, [0,1,0,1]); 


for i = 1:168
    % Get bid from policy 
    [X1,theta1,p1,bid1] = KG_ms(X1,theta1,p1, 0,10); 
    [X2,theta2,p2,bid2] = KG_ms(X2,theta2,p2, 0,10);
    [X3,theta3,p3,bid3] = KG_ms(X3,theta3,p3, 0,10); 
    
    bids = [bid1 bid2 bid3]; 
    %[testrs,testbid] = bid(testrs,a); 
    sampleAuctions = simAuctions(auctions(i)); 
    
    clicks1 = 0; 
    clicks2 = 0; 
    clicks3 = 0; 
    
 
    for j = 1:sampleAuctions
        if bid1 == bid2 & bid1 == bid3
            
        if bid1 == max(bids)
            disp('bid1 won')
            clicks1 = Clicks(truth_theta1_1,truth_theta1_2,bid1);
            totalClicks1 = totalClicks1 + clicks1; 
        elseif bid2 == max(bids)
            disp('bid2 won')
            clicks2 = Clicks(truth_theta2_1,truth_theta2_2,bid1);
            totalClicks2 = totalClicks2 + clicks2; 
        elseif bid3 == max(bids) 
            disp('bid3 won')
            clicks3 = Clicks(truth_theta3_1,truth_theta3_2,bid1);
            totalClicks3 = totalClicks3 + clicks3;
        end 
        if bid1 == bid2 
    end 
    
    % For all the different sets of theta values
     

%     hold on 
%     for col=1:length(theta1)
%         yTruth = 1./(1 + exp(-theta1 - theta2 * x));
%         plot(x,yTruth,'-.r*')
%         if p1(col) >= 0.1 && col ~= 3
% 
%             bids = theta1(:,col); 
%             y = 1./(1 + exp(-bids(1) - bids(2) * x));
%             plot(x,y,'LineWidth',10*p1(col));
%             plot(bid1, 0);
%             drawnow
%             if i ~= 168
%                 hold on
%             end 
%         end 
%         
%     end
%     clf

    profit = 20*clicks1 - clicks1*bid1;
    
    % Update learning policy
    [X1,theta1,p1] = learner_KG_hr(X1,theta1,p1,bid1,sampleAuctions,clicks1);
    [X2,theta2,p2] = learner_KG_hr(X2,theta2,p2,bid2,sampleAuctions,clicks2);
    [X3,theta3,p3] = learner_KG_hr(X3,theta3,p3,bid3,sampleAuctions,clicks3);
%     testrs = learn(testrs); 
    % Randomize truth so that it's dynamic
%     if rand >= p_change_truth
%         
%         newCol = round(rand(1)*10); 
%         theta1 = theta1(1, newCol); 
%         theta2 = theta1(2, newCol); 
%     end 
       
end 
totalClicks1 
totalClicks2 
totalClicks3
% Stop parallel processing 
%profile = gcp; 
%delete(profile)
         

        
        








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
