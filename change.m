%% ���ͷ�����·��֮�����ת��
function Route=change(VC)
NV=size(VC,1);                        
Route=[];
for i=1:NV
    Route=[Route,VC{i}];
end
end