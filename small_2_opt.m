%% 2-opt操作  只对同一辆车进行操作
function [newRoute,newVC]=small_2_opt(iter,Route_best,cap,demands,a,b,L,s,dist)
        newRoute=Route_best(iter,:);
        [optVC,~,~]=decode(newRoute,cap,demands,a,b,L,s,dist);    
        VCnum=size(optVC,1);   
        VCRand=round(rand(1,1)*(VCnum-1))+1;                                     
        optRoute=optVC{VCRand};
        optRouteLen=size(optRoute,2);
        opt1=round(rand(1,1)*(optRouteLen-1))+1;
        opt2=round(rand(1,1)*(optRouteLen-1))+1;
        if opt1<=opt2
            optmin=opt1;
            optmax=opt2;
        else
            optmin=opt2;
            optmax=opt1;
        end                               
        if optmin>1
            oneRoute=optRoute(1,1:optmin-1);
        else
            oneRoute=[];
        end 
        if optmax<optRouteLen
            threeRoute=optRoute(1,optmax+1:optRouteLen);
        else
            threeRoute=[];
        end
        twoRoute=optRoute(1,optmin:optmax);
        twoRoute=fliplr(twoRoute);      
        optRoute=[oneRoute twoRoute threeRoute];                           
        optVC{VCRand}=optRoute;                                           
        newRoute=VC_to_Route(optVC);                                    
        [newVC,~,~]=decode(newRoute,cap,demands,a,b,L,s,dist);            
end
 