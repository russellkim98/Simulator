function[simulatedClicks] = simClicks(theta1,theta2,bid)
    % input into logistic equation
    theta1
    theta2
    bid
    pWC = 1/(1 + exp(- theta1 - theta2*bid));
    simulatedClicks = binornd(1,pWC);
end 
