%% 插入操作 将某一个车的某一客户插入另一车路径中
function [newRoute,newVC]=insert_DV_client(iter,Route_best,cap,demands,a,b,L,s,dist)
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
        newoptRoute1=zeros(1,optRouteLen1-1);
        newoptRoute2=zeros(1,optRouteLen2+1);
         if opt1>1
             newoptRoute1(1,1:opt1-1)=optRoute1(1,1:opt1-1);
         end
         if opt1<optRouteLen1
             newoptRoute1(1,opt1:optRouteLen1-1)=optRoute1(1,opt1+1:optRouteLen1);
         end
         if opt2>1
             newoptRoute2(1,1:opt2-1)=optRoute2(1,1:opt2-1);
         end
        newoptRoute2(1,opt2)=optRoute1(1,opt1);
        newoptRoute2(1,opt2+1:optRouteLen2+1)=optRoute2(1,opt2:optRouteLen2);
        optVC{VCRand1}=newoptRoute1;                                       
        optVC{VCRand2}=newoptRoute2;
        newRoute=VC_to_Route(optVC);                                                        
        [newVC,~,~]=decode(newRoute,cap,demands,a,b,L,s,dist);           
    end