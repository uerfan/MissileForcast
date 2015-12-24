clc
clear all
close all
%%常见参数
format long
G = 6.67e-11;
M = 5.98e24;
Re = 6371.004e3;
u = G*M;
we = (7.292115e-5)*180/pi;%自转速度
theta = 99.0664;
fi = -0.046;
Radar_Long = 103.34;
Radar_Lati = 34.15;
Radar_L = 2000;
P_radar = [Radar_Long,Radar_Lati,Radar_L];

A1 = 228.869;
E1 = 3.769;
L1 = 3235.359157e3;
t1 = 3*60+24;
R1 = zeros(4,3);
R1(1,:) = Polar2Plane(A1,E1,L1);
R1(2,:) = Plane2Center(R1(1,:)',P_radar);
R1(3,:) = Center2Launch(R1(2,:),t1);
R1(4,:) = Launch2J2000(R1(3,:));
R1

A2 = 225.626;
E2 = 23.182;
L2 = 3412.374e3;
t2 = 8*60+57;
R2 = zeros(4,3);
R2(1,:) = Polar2Plane(A2,E2,L2);
R2(2,:) = Plane2Center(R2(1,:)',P_radar);
R2(3,:) = Center2Launch(R2(2,:),t2);
R2(4,:) = Launch2J2000(R2(3,:));
R2

%%弹道导弹落点预报
r1 = R1(4,:);
% r1=[-7071.68	-393.338	1928.53]*1e3;
r2 = R2(4,:);
% r2=[-7866.83	-1143.76	2505.785]*1e3;

v1 = [-3.45571	-2.34508	2.041128]*1e3;
v2 = [-1.41334	-2.14075	1.437845]*1e3;

sigma=0:50:500;
% sigma=0;
M_B = zeros(length(sigma),3);
DB = zeros(length(sigma),3);

T=[-5032.34	-2847.79 2682.898]*1e3;

for i=1:length(sigma)
    [M_B(i,:),RMSE_B(i,:)]=LandPoint(r1,v1,r2,v2,sigma(i));
    DB(i,:)= M_B(i,:)-T;
end
M_B
RMSE_B
DB
figure
subplot(3,1,1)
plot(M_B(:,1),'r*-')
title('均值点X');
subplot(3,1,2)
plot(M_B(:,2),'b*-')
title('均值点Y');
subplot(3,1,3)
plot(M_B(:,3),'g*-')
title('均值点Z');


figure(gcf+1)
subplot(3,1,1)
plot(RMSE_B(:,1),'r*-')
title('RMSE-X');
subplot(3,1,2)
plot(RMSE_B(:,2),'b*-')
title('RMSE-Y');
subplot(3,1,3)
plot(RMSE_B(:,3),'g*-')
title('RMSE-Z');

figure(gcf+1)
subplot(3,1,1)
plot(DB(:,1),'r*-')
subplot(3,1,2)
plot(DB(:,2),'b*-')
subplot(3,1,3)
plot(DB(:,3),'g*-')
title('均值与理想值坐标的差')

%  1.0e+06 *
% 
%     1.6894    6.1429


