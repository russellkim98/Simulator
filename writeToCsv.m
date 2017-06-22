function writeToCsv(sim_Data) 
global counter; 
csvwrite('sim_Output.csv',sim_Data,counter,0); 
counter = counter + 1; 