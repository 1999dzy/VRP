%% 计算每辆车所行驶的距离，以及所有车行驶的总距离
function [sumTD,everyTD]=travel_distance(vehicles_customer,dist)
n=size(vehicles_customer,1);                      
everyTD=zeros(n,1);
for i=1:n
    part_seq=vehicles_customer{i};                  
    if ~isempty(part_seq)
        everyTD(i)=part_length( part_seq,dist );     
    end
end
sumTD=sum(everyTD);                               

