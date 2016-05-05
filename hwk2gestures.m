clc;
clear;

nalpha=length(dir('Data/alpha/*.txt'));
nbeta=length(dir('Data/beta/*.txt'));
ndelta=length(dir('Data/delta/*.txt'));
ntest=length(dir('Test/*.txt'));
classalpha=[];
classbeta=[];
classdelta=[];


for i=1:nalpha

    location=strcat(['data/alpha/t'],int2str(i),['.txt']);
    [col1, col2]=textread(location,'%f %f');

    
    if i==1
        figure(1)
        plot(col1,col2);
    end
    
    %Determining the bounding box
    width=abs(max(col1)-min(col1));
    height=abs(max(col2)- min(col2));

    %Transforming every letter to a 1x1 box by linear transformation
    col1=col1/width;
    col2=col2/height;

    %Getting attributes
    X=calculateAttributes(col1,col2);
    
    classalpha=cat(1,classalpha,X);

end

for i=1:nbeta
    location=strcat(['data/beta/t'],int2str(i),['.txt']);
    [col1, col2]=textread(location,'%f %f');

    if i==1
        figure(2)
        plot(col1,col2);
    end
    
    %Determining the bounding box
    width=abs(max(col1)-min(col1));
    height=abs(max(col2)- min(col2));

    %Transforming every letter to a 1x1 box by linear transformation
    col1=col1/width;
    col2=col2/height;

    %Getting attributes
    X=calculateAttributes(col1,col2);
    
    classbeta=cat(1,classbeta,X);

end

for i=1:ndelta
    location=strcat(['data/delta/t'],int2str(i),['.txt']);
    [col1, col2]=textread(location,'%f %f');

    if i==1
        figure(3)
        plot(col1,col2);
    end
    
    %Determining the bounding box
    width=abs(max(col1)-min(col1));
    height=abs(max(col2)- min(col2));

    %Transforming every letter to a 1x1 box by linear transformation. THIS
    %IS THE NON DIMENSIONLIZATION PART! AFTER THIS, WE MAY USE DIRECT
    %VALUES OF THE ATTRIBUTE.
    
    col1=col1/width;
    col2=col2/height;

    %Getting attributes
    
    %Attribute 1 is length of the whole letter. (Refer calculateDist.m)
    
    % Attribute 2 is the sum of the direction cosines of the starting point and ending point of
    % each letter (Refer calculatedc.m)
    
    %Attribute 3 is the shortest distance between the start point and the end point
    %Refer calculateAttributes.m
    
    %Attribute 4 is the sum of the direction cosines of all the line
    %segments from start to the end. Refer calculatedctot.m
    
    X=calculateAttributes(col1,col2);
    
    classdelta=cat(1,classdelta,X);

end

meana=mean(classalpha);
cova=cov(classalpha);

meanb=mean(classbeta);
covb=cov(classbeta);

meand=mean(classbeta);
covd=cov(classdelta);

disp('Feature vector of alpha:')
disp(classalpha)
disp('Feature vector of beta:')
disp(classbeta)
disp('Feature vector of delta:')
disp(classdelta)
disp('Mean of alpha:')
disp(meana)
disp('Mean of beta:')
disp(meanb)
disp('Mean of delta:')
disp(meand)
disp('Covariance of alpha')
disp(cova)
disp('Covariance of beta')
disp(covb)
disp('Covariance of delta')
disp(covd)



result=[];
for i=1:ntest 
    
    %This is the TESTING
    [col1, col2]=textread(strcat(['Test/test'],int2str(i),['.txt']),'%f %f');

    %Determining the bounding box
    width=abs(max(col1)-min(col1));
    height=abs(max(col2)- min(col2));

    %Transforming every letter to a 1x1 box by linear transformation
    col1=col1/width;
    col2=col2/height;

    %Getting attributes
    testattrib=calculateAttributes(col1,col2);

    Pa=recognizePattern(meana',cova,testattrib');
    Pb=recognizePattern(meanb',covb,testattrib');
    Pd=recognizePattern(meand',covd,testattrib');

    [~,I]=max([Pa Pb Pd]);
    result=cat(1,result,I);
    
%     if I==1
%         disp(strcat(int2str(i),': Alpha!!!!'));
%         
%     elseif I==2
%         disp(strcat(int2str(i),': Beta!!!!'));
%     else disp(strcat(int2str(i),': Delta!!!!'));
%     end
end


dlmwrite('testresult.txt',result);


