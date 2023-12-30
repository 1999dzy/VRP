%% ��һһ�������ӽ��ɱ���ѡ��n��·�������в���ͻ������
function [someBestRoute,somebestVC,selectBestCost]=select_some_insert(Table,m,ratio,cusnum,cap,demands,a,b,L,s,dist)
      selectRouteNum=m*ratio;
      selectCost=zeros(selectRouteNum,1);
      selectRoutes=zeros(selectRouteNum,cusnum);
      randList=randperm(m);
      selectRand=randList(1:selectRouteNum);
      for i=1:selectRouteNum
          empty=selectRand(i);
          [newRoute,~]=insert_DV_client(empty,Table,cap,demands,a,b,L,s,dist);
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