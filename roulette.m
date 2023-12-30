%% бжел╤д
function index=roulette(p_value)
if p_value~=0
    n=length(p_value);
    p=p_value./sum(p_value);      
    pp=cumsum(p);
    R=rand;                        
    for i=1:n
        if i==1                    
            if R<=pp(i)
                index=1;
                break
            end
        else                       
            if R>=pp(i-1) && R<=pp(i)
                index=i;
                break
            end
        end
    end
else
    index=1;
end
end