%% 2-opt操作 对多辆车进行操作
function [newRoute,newVC]=big_2_opt(iter,Route_best,cap,demands,a,b,L,s,dist)
        newRoute=Route_best(iter,:); 
        RouteSize=size(newRoute,2);
        opt1=round(rand(1,1)*(RouteSize-1))+1;
        opt2=round(rand(1,1)*(RouteSize-1))+1;
         while opt1==opt2
            opt2=round(rand(1,1)*(RouteSize-1))+1;  
        end
        if opt1<=opt2
            optmin=opt1;
            optmax=opt2;
        else
            optmin=opt2;
            optmax=opt1;
        end                               
        if optmin>1
            oneRoute=newRoute(1,1:optmin-1);
        else
            oneRoute=[];
        end 
        if optmax<RouteSize
            threeRoute=newRoute(1,optmax+1:RouteSize);
        else
            threeRoute=[];
        end
        twoRoute=newRoute(1,optmin:optmax);
        twoRoute=fliplr(twoRoute);      
        newRoute=[oneRoute twoRoute threeRoute];                           
        [newVC,~,~]=decode(newRoute,cap,demands,a,b,L,s,dist);            
end
 