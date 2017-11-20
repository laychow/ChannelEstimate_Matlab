L=16;

E=8;%画图点数
Q=10;%取平均

MSE=zeros(Q,E);
MSE_temp=zeros(Q,E);
MSE_average=zeros(1,E);

%-10

sigma_p=0.1;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
for q=1:Q
	MSE_temp(q,1)=0;
	MSE(q,1)=0;
    run ('spatial_obtain.m');
    run ('Estimate_version1.m');


    for k=1:K
        MSE_temp(q,1)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
        MSE(q,1)=MSE(q,1)+MSE_temp(q,1);
    end
    MSE(q,1)=MSE(q,1)/K;
end
MSE_average(1,1)=sum(MSE(:,1))/Q;



%-5
sigma_p=10^(-0.5);
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
for q=1:Q
	MSE_temp(q,2)=0;
	MSE(q,2)=0;
    run ('spatial_obtain.m');
    run ('Estimate_version1.m');


    for k=1:K
        MSE_temp(q,2)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
        MSE(q,2)=MSE(q,2)+MSE_temp(q,2);
    end
    MSE(q,2)=MSE(q,2)/K;
end
MSE_average(1,2)=sum(MSE(:,2))/Q;



%0
sigma_p=1;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
for q=1:Q
	MSE_temp(q,3)=0;
	MSE(q,3)=0;
    run ('spatial_obtain.m');
    run ('Estimate_version1.m');


    for k=1:K
        MSE_temp(q,3)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
        MSE(q,3)=MSE(q,3)+MSE_temp(q,3);
    end
    MSE(q,3)=MSE(q,3)/K;
end
MSE_average(1,3)=sum(MSE(:,3))/Q;


%5
sigma_p=10^0.5;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
for q=1:Q
	MSE_temp(q,4)=0;
	MSE(q,4)=0;
    run ('spatial_obtain.m');
    run ('Estimate_version1.m');


    for k=1:K
        MSE_temp(q,4)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
        MSE(q,4)=MSE(q,4)+MSE_temp(q,4);
    end
    MSE(q,4)=MSE(q,4)/K;
end
MSE_average(1,4)=sum(MSE(:,4))/Q;


%10
sigma_p=10;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
for q=1:Q
	MSE_temp(q,5)=0;
	MSE(q,5)=0;
    run ('spatial_obtain.m');
    run ('Estimate_version1.m');


    for k=1:K
        MSE_temp(q,5)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
        MSE(q,5)=MSE(q,5)+MSE_temp(q,5);
    end
    MSE(q,5)=MSE(q,5)/K;
end
MSE_average(1,5)=sum(MSE(:,5))/Q;


%15
sigma_p=10^1.5;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
for q=1:Q
	MSE_temp(q,6)=0;
	MSE(q,6)=0;
    run ('spatial_obtain.m');
    run ('Estimate_version1.m');


    for k=1:K
        MSE_temp(q,6)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
        MSE(q,6)=MSE(q,6)+MSE_temp(q,6);
    end
    MSE(q,6)=MSE(q,6)/K;
end
MSE_average(1,6)=sum(MSE(:,6))/Q;


%20
sigma_p=10^2;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
for q=1:Q
	MSE_temp(q,7)=0;
	MSE(q,7)=0;
    run ('spatial_obtain.m');
    run ('Estimate_version1.m');


    for k=1:K
        MSE_temp(q,7)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
        MSE(q,7)=MSE(q,7)+MSE_temp(q,7);
    end
    MSE(q,7)=MSE(q,7)/K;
end
MSE_average(1,7)=sum(MSE(:,7))/Q;


%25
sigma_p=10^2.5;
sigma_n=1;
rho=sigma_p/sigma_n;
%run ('TrainingSequence.m');
for q=1:Q
	MSE_temp(q,8)=0;
	MSE(q,8)=0;
    run ('spatial_obtain.m');
    run ('Estimate_version1.m');


    for k=1:K
        MSE_temp(q,8)=((norm(h(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h(:,:,k)))^2;
        MSE(q,8)=MSE(q,8)+MSE_temp(q,8);
    end
    MSE(q,8)=MSE(q,8)/K;
end
MSE_average(1,8)=sum(MSE(:,8))/Q;


rho_snr=-10:5:25;
plot(rho_snr,MSE_average(1:8),'-o');