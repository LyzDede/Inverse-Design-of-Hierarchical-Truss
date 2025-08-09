function uniX =uniformFoward(refX,oriX)
    uniX=zeros(size(oriX));
    for i=1:size(oriX,1)
        uniX(i,:)=(oriX(i,:)-min(refX(i,:)))./(max(refX(i,:))-min(refX(i,:)));
    end
end