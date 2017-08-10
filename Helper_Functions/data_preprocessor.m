function [auctions,pWCFactor] = data_preprocessor()

data = csvread('ParsedParam.csv',1,0);

auctions = zeros([168 1]);
clicks = zeros([168 1]);

for x = 1:168
    everyNthRow = data(97 + x:168:end,:);
    auctions(x) = mean(everyNthRow(:,8)); 
    clicks(x) = mean(everyNthRow(:,10));
end 

pWCFactor = clicks./auctions; 

end 




