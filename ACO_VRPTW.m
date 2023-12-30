function ACO_VRPTW
%%
clear
clc
close all
tic
%% 读取文件
c101=importdata('C101.txt');    
cname='C101';
cap=200;                                                       
%%
smallopt=0;
bigopt=0;
insert=0;
change=0;
%% 提取数据信息
E=c101(1,5);                                                    
L=c101(1,6);                                                    
vertexs=c101(:,2:3);                                            
customer=vertexs(2:end,:);                                     
cusnum=size(customer,1);                                       
v_num=50;                                                      
demands=c101(2:end,4);                                          
a=c101(2:end,5);                                                
b=c101(2:end,6);                                             
width=b-a;                                                     
s=c101(2:end,7);                                            
h=pdist(vertexs);
dist=squareform(h);                                             
%% 初始化参数
m=100;                                                         
alpha=1;                                                     
beta=3;                                                         
gama=2;                                                         
delta=3;                                                       
r0=0.5;                                                         
rho=0.85;                                                       
Q=5;                                                            
Eta=1./dist;                                                   
Tau=ones(cusnum+1,cusnum+1);                                    
Table=zeros(m,cusnum);                                         
iter=1;                                                        
iter_max=100;                                                           
Route_best=zeros(iter_max,cusnum);                             
Cost_best=zeros(iter_max,1);                                    
award=0;                                                         
reception=1;                                                    
unchanged=0;                                                   
%% 迭代寻找最佳路径
while iter<=iter_max
    if (iter>=0.25*iter_max)&&(iter<=0.75*iter_max)
        rho=0.80;    
    elseif (iter>0.75*iter_max)&&(iter<=0.9*iter_max)
        r0=0.3;
        rho=0.7;     
    elseif iter>0.9*iter_max
        r0=0.5;
        rho=0.85;
    end
    %% 构建路径
    for i=1:m
        for j=1:cusnum
            r=rand;                                             
            np=next_point(i,Table,Tau,Eta,alpha,beta,gama,delta,r,r0,a,b,width,s,L,dist,cap,demands);  
            Table(i,j)=np;
        end
    end
    cost=zeros(m,1);
    NV=zeros(m,1);
    TD=zeros(m,1);   
    for i=1:m
        VC=decode(Table(i,:),cap,demands,a,b,L,s,dist);
        [cost(i,1),NV(i,1),TD(i,1)]=costFun(VC,dist);
    end
    if iter == 1
        [min_Cost,min_index]=min(cost); 
        Cost_best(iter)=min_Cost;     
        Route_best(iter,:)=Table(min_index,:);
    else
        [min_Cost,min_index]=min(cost);
        Cost_best(iter)=min(Cost_best(iter - 1),min_Cost);  
        if Cost_best(iter)==min_Cost
            Route_best(iter,:)=Table(min_index,:);
        else
            Route_best(iter,:)=Route_best((iter-1),:);
        end
    end
    %%  2-opt操作(iter>20 && Cost_best(iter)==Cost_best(iter-10))
   for i=1:100
        [newRoute,newVC]=small_2_opt(iter,Route_best,cap,demands,a,b,L,s,dist);
        optflag=Judge(newVC,cap,demands,a,b,L,s,dist);                     
        if optflag==1
            optCost=costFun(newVC,dist);
            if optCost<Cost_best(iter)                                   
                smallopt=smallopt+Cost_best(iter)-optCost;
                Route_best(iter,:)=newRoute;                    
                Cost_best(iter)=optCost;
            end
        end
   end
    %% 交换客户点操作
%    for i=1:100
%         [newRoute,newVC]=change_DV_client(iter,Route_best,cap,demands,a,b,L,s,dist);
%         changeflag=Judge(newVC,cap,demands,a,b,L,s,dist);                     
%         if changeflag==1
%             changeCost=costFun(newVC,dist);
%             if changeCost<Cost_best(iter)                                    
%                 change=change+Cost_best(iter)-changeCost;
%                 Route_best(iter,:)=newRoute;                    
%                 Cost_best(iter)=changeCost;
%             end
%         end
%    end
%     end
   %% 插入客户点操作
%    for i=1:100
%          [newRoute,newVC]=insert_DV_client(iter,Route_best,cap,demands,a,b,L,s,dist);
%          insertflag=Judge(newVC,cap,demands,a,b,L,s,dist);                    
%           if insertflag==1
%             insertCost=costFun(newVC,dist);
%             if insertCost<Cost_best(iter)                                   
%                 insert=insert+Cost_best(iter)-insertCost;
%                 Route_best(iter,:)=newRoute;                    
%                 Cost_best(iter)=insertCost;
%             end
%           end
%    end
%    end
     %%  顺序插入操作
    for i=1:100
         [newRoute,newVC]=loop_insert(iter,Route_best,cusnum,cap,demands,a,b,L,s,dist);
         loopflag=Judge(newVC,cap,demands,a,b,L,s,dist);                   
          if loopflag==1
              loopCost=costFun(newVC,dist);
            if loopCost<Cost_best(iter)                                  
                Route_best(iter,:)=newRoute;                     
                Cost_best(iter)=loopCost;
            end
          end
    end
    %%    LNS操作
     [ReRoute,ReVC]=LocalSearch(iter,Route_best,cusnum,cap,demands,a,b,L,s,dist,unchanged);
     Lnsflag=Judge(ReVC,cap,demands,a,b,L,s,dist);                     
          if Lnsflag==1
              LnsCost=costFun(ReVC,dist);
            if LnsCost<=Cost_best(iter)*(reception)                                     
                Route_best(iter,:)=ReRoute;                    
                Cost_best(iter)=LnsCost;
            end
          end
     if iter>2 && Cost_best(iter) >= Cost_best(iter-1)
         unchanged=unchanged+1;
     else
         unchanged=0;
     end
    reception=reception+unchanged*0.0005;
    if reception>1.003
        reception=1.003;
    end
    %% 
    bestR=Route_best(iter,:);
    [bestVC,bestNV,bestTD]=decode(bestR,cap,demands,a,b,L,s,dist); 
    if iter>=2
    nowBestR=Route_best(iter-1,:);
    [~,~,nowbestTD]=decode(nowBestR,cap,demands,a,b,L,s,dist);
    award=(bestTD-nowbestTD)/bestTD;
    end
    Tau=updateTau(Table,TD,m,Tau,bestR,rho,Q,cap,demands,a,b,L,s,dist,award);            
    %% 打印当前最优解
    disp(['第',num2str(iter),cname,'代最优解:'])    
    disp(['车辆使用数目：',num2str(bestNV),'，车辆行驶总距离：',num2str(bestTD)]);
    fprintf('\n')
    %% 
    iter=iter+1;
    Table=zeros(m,cusnum);
end
%% 
bestRoute=Route_best(end,:);      
[bestVC,NV,TD]=decode(bestRoute,cap,demands,a,b,L,s,dist);
draw_Best(bestVC,vertexs);
%% 绘图
figure(2)
plot(1:iter_max,Cost_best,'b')
xlabel('迭代次数')
ylabel('距离')             
title('行驶距离优化趋势图')  
flag=Judge(bestVC,cap,demands,a,b,L,s,dist);
DEL=Judge_Del(bestVC);
toc
end