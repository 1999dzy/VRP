%% 判断当前路径是否满足时间窗约束和载重量约束，0表示违反约束，1表示满足全部约束
function flag=JudgeRoute(route,cap,demands,a,b,L,s,dist)
flag=1;                         
lr=length(route);             
Ld=leave_load(route,demands);
if Ld<=cap
    [arr,bs,wait,back]=begin_s(route,a,s,dist);              
    if back<=L
        for i=1:lr
            if bs(i)>b(route(i))           
                flag=0;
            end
        end
    else
        flag=0;
    end
else
    flag=0;
end
end