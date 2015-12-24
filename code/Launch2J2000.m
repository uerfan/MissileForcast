function R1=launch2J2000(R)
theta = 99.0664;  %J2000->launch M3
fi = -0.046;      %J2000->launch M2     M2*M3

M3=[
        cosd(theta) sind(theta) 0;
        -sind(theta) cosd(theta) 0;
        0 0 1;
    ];

M2 = [
        cosd(-0.046) 0 -sind(-0.046);
        0 1 0;
        sind(-0.046) 0 cosd(-0.046);
    ];
R1 = (M2*M3)'*R';
R1 = R1';
end