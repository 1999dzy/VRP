%% 判断当前方案是否满足时间窗约束和载重量约束，0表示违反约束，1表示满足全部约束
function flag=Judge(VC,cap,demands,a,b,L,s,dist)
flag=1;                       
NV=size(VC,1);                 
init_v=vehicle_load(VC,demands);
bsv=begin_s_v(VC,a,s,dist);
violate_INTW=Judge_TW(VC,bsv,b,L);
for i=1:NV
    find1=find(violate_INTW{i}==1,1,'first');    
    if init_v(i)>cap || ~isempty(find1)
        flag=0;
        break
    end
end
end

