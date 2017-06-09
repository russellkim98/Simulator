function[simulated_num_clicks] = simClicks(avg_num_clicks, avg_num_auctions, avg_cpc, number_of_data_Points) 

x = [avg_cpc, 1, 1, number_of_data_Points]; 
y = avg_num_clicks/avg_num_auctions; 

pWC = glmfit(x,y,'binomial'); 

simulated_num_clicks = binornd(avg_num_auctions,pWC); 
end 