%% 按一一定比例从禁忌表中选择n条路径，进行循环插入客户点操作
function [newRoute,newVC]=select_some_loop(Table,m,ratio,cusnum,cap,demands,a,b,L,s,dist)
      selectRouteNum=m*ratio;
      selectCost=zeros(selectRouteNum,1);
      selectRoutes=zeros(selectRouteNum,cusnum);
      randList=randperm(m);
      selectRand=randList(1:selectRouteNum);
      for i=1:selectRouteNum
          empty=selectRand(i);
          tempRoute=Table(empty,:);
          for j=1:15
          [newRoute,~]=loop_insert(empty,Table,cusnum,cap,demands,a,b,L,s,dist);
          newVC=decode(newRoute,cap,demands,a,b,L,s,dist);
          [newCost,~,~]=costFun(newVC,dist);
          tempVC=decode(tempRoute,cap,demands,a,b,L,s,dist);
          [tempCost,~,~]=costFun(tempVC,dist);
          if newCost<tempCost
              tempRoute=newRoute;
          end
          end
          selectRoutes(i,:)=tempRoute;
      end
      for i=1:selectRouteNum
         VC=decode(selectRoutes(i,:),cap,demands,a,b,L,s,dist);
         [selectCost(i,1),~,~]=costFun(VC,dist);
      end
      [~,min_index]=min(selectCost);   
      newRoute=selectRoutes(min_index,:);
      newVC=decode(newRoute,cap,demands,a,b,L,s,dist);     
end
%%