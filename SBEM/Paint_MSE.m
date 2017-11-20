clear all;
clc;



run ('sbem_version3.m');
L=16;

E=8;%画图点数
%F=1;%取平均

MSE=zeros(1,E);
MSE_temp=zeros(1,E);
MSE_average=zeros(1,E);

% sigma_p=0.000001;
% sigma_n=1;
% rho=sigma_p/sigma_n;
% %run ('TrainingSequence.m');
% run ('spatial_obtain.m');
% run ('Estimate_version1.m');
% 
% 
% for k=1:K
% 	MSE_temp(1,1)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
% 	MSE(1,1)=MSE(1,1)+MSE_temp(1,1);
% end
% MSE(1,1)=MSE(1,1)/K;


sigma_p=0.1;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');

    run ('spatial_obtain.m');
    run ('Estimate_version1.m');


    for k=1:K
        MSE_temp(1,1)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
        MSE(1,1)=MSE(1,1)+MSE_temp(1,1);
    end
    MSE(1,1)=MSE(1,1)/K;




sigma_p=10^(-0.5);
sigma_n=1;
rho=sigma_p/sigma_n;

%run ('TrainingSequence.m');
run ('spatial_obtain.m');
run ('Estimate_version1.m');

for k=1:K
	MSE_temp(1,2)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
	MSE(1,2)=MSE(1,2)+MSE_temp(1,2);
end
MSE(1,2)=MSE(1,2)/K;



sigma_p=1;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
run ('spatial_obtain.m');
run ('Estimate_version1.m');


for k=1:K
	MSE_temp(1,3)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
	MSE(1,3)=MSE(1,3)+MSE_temp(1,3);
end
MSE(1,3)=MSE(1,3)/K;


sigma_p=10^0.5;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
run ('spatial_obtain.m');
run ('Estimate_version1.m');


for k=1:K
	MSE_temp(1,4)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
	MSE(1,4)=MSE(1,4)+MSE_temp(1,4);
end
MSE(1,4)=MSE(1,4)/K;


sigma_p=10;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
run ('spatial_obtain.m');
run ('Estimate_version1.m');


for k=1:K
	MSE_temp(1,5)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
	MSE(1,5)=MSE(1,5)+MSE_temp(1,5);
end
MSE(1,5)=MSE(1,5)/K;



sigma_p=10^1.5;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
run ('spatial_obtain.m');
run ('Estimate_version1.m');


for k=1:K
	MSE_temp(1,6)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
	MSE(1,6)=MSE(1,6)+MSE_temp(1,6);
end
MSE(1,6)=MSE(1,6)/K;


sigma_p=10^2;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
run ('spatial_obtain.m');
run ('Estimate_version1.m');


for k=1:K
	MSE_temp(1,7)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
	MSE(1,7)=MSE(1,7)+MSE_temp(1,7);
end
MSE(1,7)=MSE(1,7)/K;

sigma_p=10^2.5;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
run ('spatial_obtain.m');
run ('Estimate_version1.m');


for k=1:K
	MSE_temp(1,8)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
	MSE(1,8)=MSE(1,8)+MSE_temp(1,8);
end
MSE(1,8)=MSE(1,8)/K;


rho_snr=-10:5:25;
plot(rho_snr,MSE(1:8),'-o');



%%%%
% L=32;
% 
% E=8;
% 
% MSE=zeros(1,E);
% MSE_temp=zeros(1,E);
% 
% 
% sigma_p=0.1;
% sigma_n=1;
% rho=sigma_p/sigma_n;
% %run ('TrainingSequence.m');
% run ('spatial_obtain.m');
% run ('Estimate_version1.m');
% 
% 
% for k=1:K
% 	MSE_temp(1,1)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
% 	MSE(1,1)=MSE(1,1)+MSE_temp(1,1);
% end
% MSE(1,1)=MSE(1,1)/K;
% 
% 
% 
% sigma_p=10^(-0.5);
% sigma_n=1;
% rho=sigma_p/sigma_n;
% 
% %run ('TrainingSequence.m');
% run ('spatial_obtain.m');
% run ('Estimate_version1.m');
% 
% for k=1:K
% 	MSE_temp(1,2)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
% 	MSE(1,2)=MSE(1,2)+MSE_temp(1,2);
% end
% MSE(1,2)=MSE(1,2)/K;
% 
% 
% 
% sigma_p=1;
% sigma_n=1;
% rho=sigma_p/sigma_n;
% %run ('TrainingSequence.m');
% run ('spatial_obtain.m');
% run ('Estimate_version1.m');
% 
% 
% for k=1:K
% 	MSE_temp(1,3)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
% 	MSE(1,3)=MSE(1,3)+MSE_temp(1,3);
% end
% MSE(1,3)=MSE(1,3)/K;
% 
% 
% sigma_p=10^0.5;
% sigma_n=1;
% rho=sigma_p/sigma_n;
% %run ('TrainingSequence.m');
% run ('spatial_obtain.m');
% run ('Estimate_version1.m');
% 
% 
% for k=1:K
% 	MSE_temp(1,4)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
% 	MSE(1,4)=MSE(1,4)+MSE_temp(1,4);
% end
% MSE(1,4)=MSE(1,4)/K;
% 
% 
% sigma_p=10;
% sigma_n=1;
% rho=sigma_p/sigma_n;
% %run ('TrainingSequence.m');
% run ('spatial_obtain.m');
% run ('Estimate_version1.m');
% 
% 
% for k=1:K
% 	MSE_temp(1,5)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
% 	MSE(1,5)=MSE(1,5)+MSE_temp(1,5);
% end
% MSE(1,5)=MSE(1,5)/K;
% 
% 
% 
% sigma_p=10^1.5;
% sigma_n=1;
% rho=sigma_p/sigma_n;
% %run ('TrainingSequence.m');
% run ('spatial_obtain.m');
% run ('Estimate_version1.m');
% 
% 
% for k=1:K
% 	MSE_temp(1,6)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
% 	MSE(1,6)=MSE(1,6)+MSE_temp(1,6);
% end
% MSE(1,6)=MSE(1,6)/K;
% 
% 
% sigma_p=10^2;
% sigma_n=1;
% rho=sigma_p/sigma_n;
% %run ('TrainingSequence.m');
% run ('spatial_obtain.m');
% run ('Estimate_version1.m');
% 
% 
% for k=1:K
% 	MSE_temp(1,7)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
% 	MSE(1,7)=MSE(1,7)+MSE_temp(1,7);
% end
% MSE(1,7)=MSE(1,7)/K;
% 
% sigma_p=10^2.5;
% sigma_n=1;
% rho=sigma_p/sigma_n;
% %run ('TrainingSequence.m');
% run ('spatial_obtain.m');
% run ('Estimate_version1.m');
% 
% 
% for k=1:K
% 	MSE_temp(1,8)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
% 	MSE(1,8)=MSE(1,8)+MSE_temp(1,8);
% end
% MSE(1,8)=MSE(1,8)/K;
% 
% 
% rho_snr=-10:5:25;
% plot(rho_snr,MSE(1:8),'-o');
% hold on;
