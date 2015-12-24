function R1 = Center2Launch(R,t)
we = (7.292115e-5)*180/pi;%自转速度
fi = we*t;
M = [
    cosd(fi) sind(fi) 0;
    -sind(fi) cosd(fi) 0;
    0 0 1;
    ];
R1 = M'*R';
R1 = R1';
end
