%% 交换操作 对不同车进行交换客户点操作
function [newRoute,newVC]=change_DV_client(iter,Route_best,cap,demands,a,b,L,s,dist)
        newRoute=Route_best(iter,:);
        [optVC,~,~]=decode(newRoute,cap,demands,a,b,L,s,dist);     
        VCnum=size(optVC,1);           
        VCRand1=round(rand(1,1)*(VCnum-1))+1;                                    
        VCRand2=round(rand(1,1)*(VCnum-1))+1;   
        while VCRand1==VCRand2
            VCRand2=round(rand(1,1)*(VCnum-1))+1;  
        end
        optRoute1=optVC{VCRand1};
        optRoute2=optVC{VCRand2};
        optRouteLen1=size(optRoute1,2);                                      
        optRouteLen2=size(optRoute2,2); 
        opt1=round(rand(1,1)*(optRouteLen1-1))+1;
        opt2=round(rand(1,1)*(optRouteLen2-1))+1; 
        empty=optRoute1(1,opt1);                                           
        optRoute1(1,opt1)=optRoute2(1,opt2);
        optRoute2(1,opt2)=empty;
        optVC{VCRand1}=optRoute1;                                          
        optVC{VCRand2}=optRoute2;
        newRoute=VC_to_Route(optVC);                                                       
        [newVC,~,~]=decode(newRoute,cap,demands,a,b,L,s,dist);             
    end