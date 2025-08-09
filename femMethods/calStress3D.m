function fs=calStress3D(ps, ls, U, A, E)
      
    pvs=ps(ls(:,2),:)-ps(ls(:,1),:);
    lengths=sqrt(diag(pvs*pvs'));
    angles=pvs./repmat(lengths,1,3);
    dU=[U(ls(:,2)*3-2)-U(ls(:,1)*3-2) U(ls(:,2)*3-1)-U(ls(:,1)*3-1) U(ls(:,2)*3)-U(ls(:,1)*3)];
    
    fs=E*diag(angles*dU').*A'./lengths;
    
%{  
    fs=zeros(1,length(ls));

    for i=1:size(ls,1)
        barLength=dist(ps(ls(i,1),:),ps(ls(i,2),:));
        cosX=(ps(ls(i,2),1)-ps(ls(i,1),1))/barLength;
        cosY=(ps(ls(i,2),2)-ps(ls(i,1),2))/barLength;
        cosZ=(ps(ls(i,2),3)-ps(ls(i,1),3))/barLength;
        u1=U(ls(i,1)*3-2)*cosX+U(ls(i,1)*3-1)*cosY+U(ls(i,1)*3)*cosZ;
        
        u2=U(ls(i,2)*3-2)*cosX+U(ls(i,2)*3-1)*cosY+U(ls(i,2)*3)*cosZ;
        f=E*A(i)*(u2-u1)/barLength;
        fs(i)=f;
    end

    %}
    %df=ffs-fs'

    
end