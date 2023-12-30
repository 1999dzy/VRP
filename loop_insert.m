%% 插入操作 将某一个车的某一客户插入另一车路径中
function [newRoute,newVC]=loop_insert(iter,Route_best,cusnum,cap,demands,a,b,L,s,dist)
        TempTable=zeros(cusnum,cusnum);
        newRoute=Route_best(iter,:);
        index=round(rand(1,1)*(cusnum-1))+1;                                    
        temp=newRoute(index);
        newRoute(index)=[];
        for i=1:cusnum
            if i>=2
            TempTable(i,1:i-1)=newRoute(1:i-1);
            end
            TempTable(i,i)=temp;
            TempTable(i,i+1:cusnum)=newRoute(i:cusnum-1);
        end
       TempCost=zeros(cusnum,1);
       for i=1:cusnum
        VC=decode(TempTable(i,:),cap,demands,a,b,L,s,dist);
        [TempCost(i,1),~,~]=costFun(VC,dist);
       end
        [~,min_index]=min(TempCost); 
        newRoute=TempTable(min_index,:);
        newVC=decode(newRoute,cap,demands,a,b,L,s,dist);
    end