AS=4:2:32;

h1=plot(AS,res(1,:),'-o','Linewidth',1,'Color',[56/255 145/255 204/255]);
xlabel('AS/degree');
ylabel('\tau');
grid on;
hold on;

h2=plot(AS,res(2,:),'-s','Linewidth',1,'Color',[241/255 194/255 81/255]);
hold on;

h3=plot(AS,res(3,:),'-^','Linewidth',1,'Color',[145/255 188/255 87/255]);
hold on;

legend([h3 h2 h1],'SNR=10','SNR=15','SNR=20');

grid minor
