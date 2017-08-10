addpath(genpath('~/AuctionProject')); 
% Initialize three policies
[X1,thetas1, p1] = init_KG(); 
[X2,thetas2, p2] = init_KG(); 
[X3,w_est, q_est] = init_logKG(5); 

% Clean up data and get the average number of auctions and the probability of a click in an hour 
[auctions,pAuction_Click] = data_preprocessor(); 


% Get location adjustment values
location_Constant = location_preprocessor(53,21,97); 



thetaOne = zeros(168,1); 
% Calculate the theta value 
for i = 1:168 
    thetaOne(i) =  -log(1/pAuction_Click(i) - 1) - 7; 
end 


% Set a truth for the second theta value 
truth_theta_2 =0.5; 

% Initialize total number of clicks
totalClicks = zeros(1,3); 



% Probability of changing the truth 
p_change_truth = 0.9; 

winIndex = zeros(1,3); 

for i = 1:168
    
    % Initialize bids 
    bid1 = KG_ms(X1,thetas1,p1, 100,10); 
    bid2 = KG_ms(X2,thetas2,p2, 120,17);
    bid3 = logKG(X3,w_est,q_est, 93); 
    
    % Get number of auctions for that hour 
    auctionHour = simAuctions(auctions(i)); 
 
    % Create a vector for the bids and the clicks 
    bids = [bid1 bid2 bid3(1)]; 
    clicks = zeros(1,3); 
    
    % For every auction, get the winning bid and get the number of clicks
    % and record it 
    for j = 1:auctionHour
        winningBidIndex = bid_Policy(bids);
        clicks(winningBidIndex) = clicks(winningBidIndex) + simClicks(thetaOne(i) + location_Constant, truth_theta_2, bids(winningBidIndex));
        totalClicks(winningBidIndex) = totalClicks(winningBidIndex) + clicks(winningBidIndex);
        winIndex(winningBidIndex) = winIndex(winningBidIndex) + 1; 

        
    end 
 
    
     % Update learning policy
    [thetas1,p1] = learn_KG(bids(1),thetas1,p1,auctionHour,clicks(1));
    [thetas2,p2] = learn_KG(bids(2),thetas2,p2,auctionHour,clicks(2));
    [w_est,q_est] = learn_logKG(bid3,w_est,q_est,auctionHour,clicks(3));
    
    
end
totalClicks 
winIndex 
    
    
    
    
    
    
    
