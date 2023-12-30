%% 找出Removed数组中任一个元素的cheapest insertion point
function [minInsertPoint,minAdd]= cheapestIP( rv,rfvc,L,a,b,s,dist,demands,cap)
realRoute=VC_to_Route(rfvc);
cumnum=size(realRoute,2);
minInsertPoint=1;                
minAdd=realmax('single');         
for i=1:cumnum+1
    [VC,~,~]=decode(realRoute,cap,demands,a,b,L,s,dist);
    costBefore=costFun(VC,dist);       
    if i==1
        temp_r=[rv realRoute];
    elseif i==cumnum+1
        temp_r=[realRoute rv];
    else
        temp_r=[realRoute(1:i-1) rv realRoute(i:end)];
    end
    [VC,~,~]=decode(temp_r,cap,demands,a,b,L,s,dist);
    costAfter=costFun(VC,dist);      
    delta=costAfter-costBefore;                      
    if delta<minAdd
         minInsertPoint=i;
         minAdd=delta;
     end
end
end

