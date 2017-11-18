%UL

clear all;
clc;
%run('TrainingSequence.m');
load('B_index.mat');


%分组

OMEGA=tau/4;


%初始化
B_index_grouped=zeros(3,K);
B_index_grouped(1,1:K)=B_index; 
B_index_grouped(2,1:K)=0; 
for i=1:K
	B_index_grouped(3,i)=i;  %记下原始的用户号
end

%索引排序
for i=1:K
	for j=i+1:K
		if B_index_grouped(1,i)>B_index_grouped(1,j)
			temp=B_index_grouped(:,i);
			B_index_grouped(:,i)=B_index_grouped(:,j);
			B_index_grouped(:,j)=temp;
		end
	end
end

%for g=1:K
% 	for i=1:K
% 		for k=i+1:K-1
% 			if (B_index_grouped(2,i)~=g)
% 			B_index_grouped(2,i)=g;
%         	else continue;
% 			end
% 			if (B_index_grouped(2,k+1)~=g)
% 				if B_index_grouped(1,k+1)-B_index_grouped(1,k)>=tau+OMEGA
% 			   B_index_grouped(2,k+1)=g;
% 			
% 				end
% 			end
% 		end
% 	end
    
%end

for g=1:K
    for k_s=g:K
    	if k_s==1 
    		B_index_grouped(2,k_s)=1;
            k=1;
    		break;
        
        elseif (B_index_grouped(2,k_s)~=(g-1))&&(B_index_grouped(2,k_s)==0)
            B_index_grouped(2,k_s)=g;
    		k=k_s;
    		break;
    	end
    end
    a=1;
        while k+a<=K
        	
        	if B_index_grouped(2,k+a)~=g
        		if (B_index_grouped(1,k+a)-B_index_grouped(1,k))>=(tau+OMEGA)&&(B_index_grouped(2,k+a)==0)
                    B_index_grouped(2,k+a)=g;
                    k=k+a;
                    a=1;
                else a=a+1;
                end
            else a=a+1;
            end
        end
    
end






        



%         if (B_index_grouped(2,k)~=g)
%             B_index_grouped(2,k)=g;
%         end
% 
% 
% 
% 
% 
% 
%         for i=1:K-k
%             if (B_index_grouped(2,k+i)~=g)
%  				if B_index_grouped(1,k+1)-B_index_grouped(1,k)>=tau+OMEGA
%                      B_index_grouped(2,k+1)=g;
%                 else continue;
%                 end
%             end
                
