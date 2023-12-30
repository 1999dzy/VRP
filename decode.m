%% ½âÂë
function [VC,NV,TD]=decode(route_k,cap,demands,a,b,L,s,dist)
route_k(route_k==0)=[];                             
cusnum=size(route_k,2);                           
VC=cell(cusnum,1);                                 
count=1;                                            
preroute=[];                                        
for i=1:cusnum
    preroute=[preroute,route_k(i)];                 
    flag=JudgeRoute(preroute,cap,demands,a,b,L,s,dist);
    if flag==1
        VC{count}=preroute;               
    else
        preroute=route_k(i);     
        count=count+1;
        VC{count}=preroute;     
    end
end
[VC,NV]=deal_vehicles_customer(VC);                    
TD=travel_distance(VC,dist);                           
end