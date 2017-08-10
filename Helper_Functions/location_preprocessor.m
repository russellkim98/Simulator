function [location_Constant] = location_preprocessor(country,region,city)

data = csvread('LocationValues.csv',1,0); 
countryConstant = data(country,2); 
regionConstant = data(region,4); 
cityConstant = data(city,6); 

location_Constant = countryConstant + regionConstant + cityConstant; 

end 