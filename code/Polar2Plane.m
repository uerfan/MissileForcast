%%�����굽��ƽ����
function R = Polar2Plane(A,E,R)
y = R*sind(E);
z = R*cosd(E)*sind(A);
x = R*cosd(E)*cosd(A);
R = [x,y,z];