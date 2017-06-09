function [simulated_num_auctions] = simAuctions(avg_num_auctions)

simulated_num_auctions = poissrnd(avg_num_auctions);

end 


