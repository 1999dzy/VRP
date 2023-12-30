%% 计算每辆车配送路线上在各个点开始服务的时间，还计算返回集配中心时间
function bsv=begin_s_v(vehicles_customer,a,s,dist)
n=size(vehicles_customer,1); 
bsv=cell(n,1);
for i=1:n
    route=vehicles_customer{i};
    [arr,bs,wait,back]=begin_s(route,a,s,dist);
    bsv{i}=[bs,back];
end
end