%% 检查最优解中是否存在元素丢失的情况
function DEL=Judge_Del(op_fvc)
NV=size(op_fvc,1);
route=[];
for i=1:NV
    route=[route op_fvc{i}];
end
sr=sort(route);
LEN=length(sr);
INIT=1:100;
DEL=setxor(sr,INIT);
end

