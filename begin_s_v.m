%% ����ÿ��������·�����ڸ����㿪ʼ�����ʱ�䣬�����㷵�ؼ�������ʱ��
function bsv=begin_s_v(vehicles_customer,a,s,dist)
n=size(vehicles_customer,1); 
bsv=cell(n,1);
for i=1:n
    route=vehicles_customer{i};
    [arr,bs,wait,back]=begin_s(route,a,s,dist);
    bsv{i}=[bs,back];
end
end