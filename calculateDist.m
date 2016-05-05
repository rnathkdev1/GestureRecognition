function dist= calculateDist(col1,col2)

l=length(col1);
dist=0;

for i=1:l-1
    dist=dist+sqrt((col1(i+1)-col1(i))^2 + (col2(i+1)-col2(i))^2);
end


end
