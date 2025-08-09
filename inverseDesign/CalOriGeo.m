function OriGeos =CalOriGeo(geos,n)
    OriGeos=zeros(size(geos));
    a=n/2+1;
    b=n/2;
    
    OriGeos(a+1,:)=geos(1,:);
    for i=2:b
        OriGeos(a+i,:)=geos(i,:)-geos(i-1,:);
    end
    
    for i=1:b
        OriGeos(i,:)=geos(b+i,:).*geos(i,:);
    end
    
    OriGeos(a,:)=geos(n+1,:)/2;
    OriGeos(n+2:size(geos,1),:)=geos(n+2:size(geos,1),:);
    
end