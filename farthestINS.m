%% ��Զ��������ʽ������С����Ŀ�������������Ԫ���ҳ���
function [bestPoint,maxAdd,removeCum]=farthestINS(removed,rfvc,L,a,b,s,dist,demands,cap )
nr=length(removed);                   
outcome=zeros(nr,3);
for i=1:nr
    [minInsertPoint,minAdd]= cheapestIP( removed(i),rfvc,L,a,b,s,dist,demands,cap);
    outcome(i,1)=minInsertPoint;
    outcome(i,2)=minAdd;
    outcome(i,3)=removed(i);
end
[mc,mc_index]=max(outcome(:,2));
bestPoint=outcome(mc_index,1);
maxAdd=outcome(mc_index,2);
removeCum=outcome(mc_index,3);
end

