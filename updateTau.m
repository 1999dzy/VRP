%% 更新路径R的信息素
function Tau=updateTau(Table,TD,m,Tau,bestR,rho,Q,cap,demands,a,b,L,s,dist,award)
Pbest=0.05;
[~,~,bestTD]=decode(bestR,cap,demands,a,b,L,s,dist);
cusnum=size(dist,1)-1;
TauMax=1/((1-rho)*bestTD);   
TauMin=TauMax*(1-Pbest^(1/cusnum))/((cusnum/2-1)*Pbest^(1/cusnum));
Delta_Tau=zeros(cusnum+1,cusnum+1);
delta_Tau=Q/bestTD*(1+award);
 for i = 1:m
%         for j = 1:cusnum-1
%             Tau(Table(i,j),Table(i,j+1)) = ...      
%                 rho*Tau(Table(i,j),Table(i,j+1))+Q/TD(i);  
% %             if Tau(Table(i,j),Table(i,j+1))>TauMax   
% %                 Tau(Table(i,j),Table(i,j+1))=TauMax;
% %             end
% %             if Tau(Table(i,j),Table(i,j+1))<TauMin
% %                 Tau(Table(i,j),Table(i,j+1))=TauMin;
% %             end
%         end
%         Tau(Table(i,cusnum),1) = ...
%             rho*Tau(Table(i,cusnum),1)+Q/TD(i);     
 end
for j=1:cusnum-1
    Delta_Tau(bestR(j),bestR(j+1))=Delta_Tau(bestR(j),bestR(j+1))+delta_Tau;
    Tau(bestR(j),bestR(j+1))=rho*Tau(bestR(j),bestR(j+1))+Delta_Tau(bestR(j),bestR(j+1));
    if Tau(bestR(j),bestR(j+1))>TauMax    
        Tau(bestR(j),bestR(j+1))=TauMax;   
    end
    if Tau(bestR(j),bestR(j+1))<TauMin
        Tau(bestR(j),bestR(j+1))=TauMin;   
    end
end
Delta_Tau(bestR(cusnum),1)=Delta_Tau(bestR(cusnum),1)+delta_Tau;  
Tau(bestR(cusnum),1)=rho*Tau(bestR(cusnum),1)+Delta_Tau(bestR(cusnum),1);  
end



