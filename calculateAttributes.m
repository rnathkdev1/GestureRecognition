function X=calculateAttributes(col1,col2)


%Attribute 1 is length of the whole letter.

len=calculateDist(col1,col2);

% Attribute 2 is the sum of the direction cosines of the starting point and ending point of
% each letter

dc=calculatedc(col1,col2);

%Attribute 3 is the shortest distance between the start point and the end point
l=length(col1);

dist= sqrt((col1(l)-col1(1))^2 + (col2(l)-col2(1))^2);

%Attribute 4 is the sum of the direction cosines of all the line
%segments from start to the end.

angle1=calculatedctot(col1,col2);

%Return all attributes to the main program
X=[len,dc,dist,angle1];
end