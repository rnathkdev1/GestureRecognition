function angle1=calculatedctot(col1,col2)

l=length(col1);
angle1=0;
for i=1:l-1
    complex1=col1(i)-col1(i+1) + 1j*(col2(i)-col2(i+1));
    temp=(angle(complex1));
%     if (temp>180)
%         temp=temp-360;
%     end

    angle1=angle1+temp;
    
end
