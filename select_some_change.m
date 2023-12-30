%% 按一一定比例从禁忌表中选择n条路径，进行交换客户点操作
function [someBestRoute,somebestVC,selectBestCost]=select_some_change(Table,m,ratio,cusnum,cap,demands,a,b,L,s,dist)
      selectRouteNum=m*ratio;
      selectCost=zeros(selectRouteNum,1);
      selectRoutes=zeros(selectRouteNum,cusnum);
      randList=randperm(m);
      selectRand=randList(1:selectRouteNum);
      for i=1:selectRouteNum
          empty=selectRand(i);
          [newRoute,~]=change_DV_client(empty,Table,cap,demands,a,b,L,s,dist);
          selectRoutes(i,:)=newRoute;
      end
      for i=1:selectRouteNum
         VC=decode(selectRoutes(i,:),cap,demands,a,b,L,s,dist);
         [selectCost(i,1),~,~]=costFun(VC,dist);
      end
      [selectBestCost,min_index]=min(selectCost);    
      someBestRoute=selectRoutes(min_index,:);
      somebestVC=decode(someBesRoute,cap,demands,a,b,L,s,dist);     
end
%%