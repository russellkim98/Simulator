% Initialize three policies
[X1,theta1, p1] = init_KG(); 
[X2,theta2, p2] = init_KG(); 
[X3,theta3, p3] = init_KG(); 

% Clean up data and get the average number of auctions in an hour 
auctions = data_preprocessor(); 

% Initialize total number of clicks
totalClicks = zeros(1,3); 

% Set a truth 
truth_theta_1 = 7; 
truth_theta_2 = -2; 


% Probability of changing the truth 
p_change_truth = 0.9; 

for i = 1:168
    
    % Initialize bids 
    bid1 = KG_ms(X1,theta1,p1, 100,10); 
    bid2 = KG_ms(X2,theta2,p2, 100,10);
    bid3 = KG_ms(X3,theta3,p3, 100,10); 
    
    % Get number of auctions for that hour 
    auctionHour = simAuctions(auctions(i)); 
 
    
    bids = [bid1 bid2 bid3]; 
    clicks = zeros(1,3); 
    
    for j = 1:auctionHour
        winningBidIndex = bid_Policy(bids);
        clicks(winningBidIndex) = clicks(winningBidIndex) + simClicks(truth_theta_1, truth_theta_2, bids(winningBidIndex));
        totalClicks(winningBidIndex) = totalClicks(winningBidIndex) + clicks(winningBidIndex); 
        
    end 
    
 
    
     % Update learning policy
    [theta1,p1] = learn_KG(bids(1),theta1,p1,auctionHour,clicks(1));
    [theta2,p2] = learn_KG(bids(2),theta2,p2,auctionHour,clicks(2));
    [theta3,p3] = learn_KG(bids(3),theta3,p3,auctionHour,clicks(3));
    
    
end 
    
    
    
    
    
    
    
