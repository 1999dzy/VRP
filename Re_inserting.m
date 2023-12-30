%% 将被移出的顾客重新插回所得到的新的车辆顾客分配方案
function [ ReRoute,ReVC] = Re_inserting(removed,rfvc,L,a,b,s,dist,demands,cap)
realRoute=VC_to_Route(rfvc);
cumnum=size(realRoute,2);
while ~isempty(removed)
    [bestPoint,maxAdd,removeCum]=farthestINS(removed,rfvc,L,a,b,s,dist,demands,cap );
    removed(removed==removeCum)=[];
    if bestPoint==1
        realRoute=[removeCum realRoute];
    elseif bestPoint==cumnum+1
        realRoute=[realRoute removeCum];
    else
        realRoute=[realRoute(1:bestPoint-1) removeCum realRoute(bestPoint:end)];
    end
    [VC,~,~]=decode(realRoute,cap,demands,a,b,L,s,dist);
    rfvc=VC;
end
ReRoute=realRoute;
[VC,~,~]=decode(ReRoute,cap,demands,a,b,L,s,dist);
ReVC=VC;
end

