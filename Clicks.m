function[simulatedClicks] = Clicks(theta0,theta1,bid)
    % input into logistic equation 
    pWC = 1/(1 + exp(-theta0 - theta1 * bid));
    simulatedClicks = binornd(1,pWC);
end 
