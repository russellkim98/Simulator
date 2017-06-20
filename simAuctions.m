function [simulated_num_auctions] = simAuctions(avg_num_auctions)


simulated_num_auctions = poissrnd(normrnd(avg_num_auctions,0.02));

end 


