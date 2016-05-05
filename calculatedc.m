function dc=calculatedc(col1,col2)

l=length(col1);
complex1=col1(1)-col1(2) + 1j*(col2(1)-col2(2));
angle1=radtodeg(angle(complex1));
if (angle1>180)
    angle1=angle1-360;
end


complex2=col1(l)-col1(l-1) + 1j*(col2(l)-col2(l-1));
angle2=radtodeg(angle(complex2));
if (angle2>180)
    angle2=angle2-360;
end

dc=angle1+angle2;

end