%% ����һ��·���ϳ���������˿͵�ʱ�䣬�Ը��˿͵Ŀ�ʼ����ʱ�䣬�Ը��˿͵ĵȴ�ʱ�䣬�Լ������������ĵ�ʱ��
function [arr,bs,wait,back]=begin_s(route,a,s,dist)  
n=length(route);                        
arr=zeros(1,n);                         
bs=zeros(1,n);                         
wait=zeros(1,n);                        
arr(1)=dist(1,route(1)+1);             
bs(1)=max(a(route(1)),dist(1,route(1)+1)); 
wait(1)=bs(1)-arr(1); 
for i=1:n
    if i~=1
        arr(i)=bs(i-1)+s(route(i-1))+dist(route(i-1)+1,route(i)+1);   
        bs(i)=max(a(route(i)),bs(i-1)+s(route(i-1))+dist(route(i-1)+1,route(i)+1));
        wait(i)=bs(i)-arr(i);
    end
end
back=bs(end)+s(route(end))+dist(route(end)+1,1);
end