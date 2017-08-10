function[winningBidIndex] = bid_Policy(bids)

    max_indices = find(bids == max(bids));
    winningBidIndex = max_indices(randi(length(max_indices)));

end 