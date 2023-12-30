%% ����ת�ƹ�ʽ���ҵ�����k��i������ƶ�������һ����j��j�����������������ʱ��Լ������δ������k������Ĺ˿�
function j=next_point(k,Table,Tau,Eta,alpha,beta,gama,delta,r,r0,a,b,width,s,L,dist,cap,demands)
route_k=Table(k,:);                                         
i=route_k(find(route_k~=0,1,'last'));                       
if isempty(i)
    i=0;
end
route_k(route_k==0)=[];                                   
cusnum=size(Table,2);                                      
allSet=1:cusnum;                                            
unVisit=setxor(route_k,allSet);                             
uvNum=length(unVisit);                                      
[VC,NV,TD]=decode(route_k,cap,demands,a,b,L,s,dist);        
if ~isempty(VC)
    route=VC{end,1};                                          
else
    route=[];
end
lr=length(route);                                          
preroute=zeros(1,lr+1);                                    
preroute(1:lr)=route;
Nik=next_point_set(k,Table,cap,demands,a,b,L,s,dist);     

%% ���r<=r0��j=max{[Tau(i,j)]^alpha * [Eta(i+1,j+1)]^beta * [1/width(j)]^gama * [1/wait(j)]^delta}
if r<=r0
    if ~isempty(Nik)
        Nik_num=length(Nik);
        p_value=zeros(Nik_num,1);                         
        for h=1:Nik_num
            j=Nik(h);
            preroute(end)=j;
            [~,~,wait,~]=begin_s(preroute,a,s,dist);      
            if wait(end)==0
                wait(end)=1e-8;
            end
            p_value(h,1)=((Tau(i+1,j+1))^alpha)*((Eta(i+1,j+1))^beta)*((1/width(j))^gama)*((1/wait(end))^delta);   
        end
        [~,maxIndex]=max(p_value);                          
        j=Nik(maxIndex);                                   
    else
        p_value=zeros(uvNum,1);                            
        for h=1:uvNum
            j=unVisit(h);
            preroute(end)=j;
            [~,~,wait,~]=begin_s(preroute,a,s,dist);
            if wait(end)==0
                wait(end)=1e-8;
            end
            p_value(h,1)=((Tau(i+1,j+1))^alpha)*((Eta(i+1,j+1))^beta)*((1/width(j))^gama)*((1/wait(end))^delta);
        end
        [~,maxIndex]=max(p_value);                         
        j=unVisit(maxIndex);                                
    end
else
    %% ���r>r0�����ݸ��ʹ�ʽ�����̶ķ�ѡ���j
    if ~isempty(Nik)
        Nik_num=length(Nik);
        p_value=zeros(Nik_num,1);                          
        for h=1:Nik_num
            j=Nik(h);
            preroute(end)=j;
            [~,~,wait,~]=begin_s(preroute,a,s,dist);
            if wait(end)==0
                wait(end)=1e-8;  
            end
            p_value(h,1)=((Tau(i+1,j+1))^alpha)*((Eta(i+1,j+1))^beta)*((1/width(j))^gama)*((1/wait(end))^delta);
        end
        index=roulette(p_value);                           
        j=Nik(index);                                      
    else
        p_value=zeros(uvNum,1);                             
        for h=1:uvNum
            j=unVisit(h);
            preroute(end)=j;
            [~,~,wait,~]=begin_s(preroute,a,s,dist);
            if wait(end)==0
                wait(end)=1e-8;
            end
            p_value(h,1)=((Tau(i+1,j+1))^alpha)*((Eta(i+1,j+1))^beta)*((1/width(j))^gama)*((1/wait(end))^delta);
        end
        index=roulette(p_value);                            
        j=unVisit(index);                                  
    end
end
end