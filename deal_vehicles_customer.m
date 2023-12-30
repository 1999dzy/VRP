%% 根据vehicles_customer整理出final_vehicles_customer，将vehicles_customer中空的数组移除
function [ final_vehicles_customer,vehicles_used ] = deal_vehicles_customer( vehicles_customer )
vecnum=size(vehicles_customer,1);               
final_vehicles_customer={};                    
count=1;                                       
for i=1:vecnum
    par_seq=vehicles_customer{i};               
    if ~isempty(par_seq)                        
        final_vehicles_customer{count}=par_seq;
        count=count+1;
    end
end
final_vehicles_customer=final_vehicles_customer';       
vehicles_used=size(final_vehicles_customer,1);          
end

