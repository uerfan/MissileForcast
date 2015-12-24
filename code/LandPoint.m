function [MEAN,RMSE]=LandPoint(r11,v1,r12,v2,sigma)
G = 6.67e-11;
M = 5.98e24;
Re = 6371.004e3;
u = G*M;

Len=1000;
x=zeros(1,Len);
y=zeros(1,Len);
z=zeros(1,Len);
for i=1:Len
    r1=r11+sigma.*randn(1,3);mr1=norm(r1);
    r2=r12+sigma.*randn(1,3);mr2=norm(r2);
    h=cross(r1,v1);mh=norm(h);p=mh.^2/u;
    mv=norm(v1);
    a=-u/(mv.^2-2*u/norm(r1));
    e=(1-p/a).^0.5;

    cth_P=(p/mr1-1)/e;
    th_P=acos(cth_P);
    P=[-sin(pi-th_P)*mr1,cos(pi-th_P)*mr1];

%     h=cross(r2,v2);mh=norm(h);p=mh.^2/u;
%     mv=norm(v2);
%     a=-u/(mv.^2-2*u/norm(r2));
%     e=(1-p/a).^0.5;
    
    cth_Q=(p/mr2-1)/e;
    th_Q=acos(cth_Q);
    Q=[-sin(pi-th_Q)*mr2,cos(pi-th_Q)*mr2];
    
    cth=(p/Re-1)/e;
    th=acos(cth);
    B=[sin(pi-th)*Re,cos(pi-th)*Re];
    % B=getXYd(r3,v3);
    % B(1)=-B(1);
    %Bµ„º∆À„
%     r1 
%     r2
%     P
%     Q
%     B
%     syms x y z
%     [x,y,z]=solve(r1*([x y z])'==P*B',r2*([x y z])'==Q*B',norm([x y z])==Re);
    P1=r1(1);P2=r1(2);P3=r1(3); 
    Q1=r2(1);Q2=r2(2);Q3=r2(3); 
    d1=P*B'; d2=Q*B';
    
    t11=(d1*Q2-d2*P2)/(P3*Q2-Q3*P2);
    t12=-(P1*Q2-Q1*P2)/(P3*Q2-Q3*P2);
    
    t21=(d1*Q3-d2*P3)/(P2*Q3-Q2*P3);
    t22=-(P1*Q3-Q1*P3)/(P2*Q3-Q2*P3);
    
%     posi=solve(x.^2+(t11-t12*x).^2+(t21-t22*x).^2==Re.^2);
    xa=(1+t12.^2+t22.^2);xb=2*(t11*t12+t21*t22);xc=t11.^2+t21.^2-Re.^2;
    
    x(i)=-xb/(2*xa)-sqrt(xb.^2-4*xa*xc)/(2*xa);
    z(i)=t11+t12*x(i);
    y(i)=t21+t22*x(i);
    x(i)=real(x(i));
    y(i)=real(y(i));
    z(i)=real(z(i));
end
MEAN=[mean(x),mean(y),mean(z)];
RMSE=[std(x),std(y),std(z)];
