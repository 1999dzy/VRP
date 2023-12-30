%% 计算一个配送方案的总成本=cd*车辆使用数目+ct*车辆行驶总距离
function [cost,NV,TD]=costFun(VC,dist)
NV=size(VC,1);                      
TD=travel_distance(VC,dist);        
if NV>16
    cost=TD+NV*1000;
else
    cost=TD;
end
end