function[simulatedClicks] = Clicks(theta0,theta1,bid)

    pWC = (exp(theta0 - theta1 * bid)/(1 + exp(theta0 - theta1 * bid))
    simulatedClicks = binornd(1,pWC); 
    return simulatedClicks
end 
