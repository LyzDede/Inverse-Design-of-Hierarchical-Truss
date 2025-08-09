function backX =uniformBack(oriX,uniX)
    uniX(uniX < 0) = 0;
    backX=zeros(size(uniX));
    for i=1:size(oriX,1)
        backX(i,:)=uniX(i,:)*(max(oriX(i,:))-min(oriX(i,:)))+min(oriX(i,:));
    end
end