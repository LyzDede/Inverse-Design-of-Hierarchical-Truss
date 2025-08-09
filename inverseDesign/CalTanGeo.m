function tanGeos =CalTanGeo(geos,n)
    tanGeos=zeros(size(geos));
    a=n/2+1;
    b=n/2;
    for i=1:b
        for j=0:i-1
            tanGeos(i,:)=tanGeos(i,:)+geos(a+i-j,:);
        end
    end
    
    for i=1:b
        tanGeos(b+i,:)=geos(i,:)./tanGeos(i,:);
    end
    
    tanGeos(n+1,:)=geos(a,:)*2;
    tanGeos(n+2:size(geos,1),:)=geos(n+2:size(geos,1),:);
    
end