%生成导频序列
%load('tau.mat');
%run('sbem_version2.m');
%L=16; %也可以选32,64
%sigma_p=10;   %sigma_p^2


S=zeros(L,tau);
Ss_temp=rand(L,L);
S_temp=orth(Ss_temp);
S=S_temp(:,1:tau).*sqrt(L*sigma_p);
% save S;
% save sigma_p;
% save L;