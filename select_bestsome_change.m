%% 选出最好的部分路径，进行交换客户点操作
function [bestRoute,bestVC,bestCost]=select_bestsome_change(Table,m,ratio,cusnum,cost,cap,demands,a,b,L,s,dist)
        SelectNumsByRatio=m*ratio;
        selectRoutesByRatio=zeros(SelectNumsByRatio,cusnum);
    tempCost=cost;
    costByRatio=zeros(SelectNumsByRatio,1);
    for i=1:SelectNumsByRatio
        [min_Cost,min_index]=min(tempCost);
        selectRoutesByRatio(i,:)=Table(min_index,:);
        tempCost(min_index)=inf;
    end
      for i=1:SelectNumsByRatio
          empty=selectRoutesByRatio(i,:);
          [newRoute,~]=change_DV_client(empty,Table,cap,demands,a,b,L,s,dist);
          selectRoutesByRatio(i,:)=newRoute;
      end
      for i=1:SelectNumsByRatio
         VC=decode(selectRoutesByRatio(i,:),cap,demands,a,b,L,s,dist);
         [costByRatio(i,1),~,~]=costFun(VC,dist);
      end
      [bestCost,min_index]=min(costByRatio);    
      bestRoute=selectRoutesByRatio(min_index,:);
      bestVC=decode(bestRoute,cap,demands,a,b,L,s,dist);     
end