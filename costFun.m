%% ����һ�����ͷ������ܳɱ�=cd*����ʹ����Ŀ+ct*������ʻ�ܾ���
function [cost,NV,TD]=costFun(VC,dist)
NV=size(VC,1);                      
TD=travel_distance(VC,dist);        
if NV>16
    cost=TD+NV*1000;
else
    cost=TD;
end
end