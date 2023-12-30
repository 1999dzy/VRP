%% 找到蚂蚁k从i点出发可以移动到的下一个点j的集合，j点必须是满足容量及时间约束且是未被蚂蚁k服务过的顾客
function Nik=next_point_set(k,Table,cap,demands,a,b,L,s,dist)
route_k=Table(k,:);                                     
cusnum=size(Table,2);                                 
route_k(route_k==0)=[];                                 
if ~isempty(route_k)
    [VC,NV,TD]=decode(route_k,cap,demands,a,b,L,s,dist);    
    route=VC{end,1};                                       
    lr=length(route);                                      
    preroute=zeros(1,lr+1);                                 
    preroute(1:lr)=route;
    allSet=1:cusnum;                                        
    unVisit=setxor(route_k,allSet);                         
    uvNum=length(unVisit);                                 
    Nik=zeros(uvNum,1);                                   
    for i=1:uvNum
        preroute(end)=unVisit(i);                          
        flag=JudgeRoute(preroute,cap,demands,a,b,L,s,dist); 
        if flag==1
            Nik(i)=unVisit(i);
        end
    end
    Nik(Nik==0)=[];                                        
else
    Nik=1:cusnum;                                      
end
end