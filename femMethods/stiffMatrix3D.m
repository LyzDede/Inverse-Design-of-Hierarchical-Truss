function K=stiffMatrix3D(ps, ls, A, E)
    lenK=length(ps)*3;
    K=sparse(zeros(lenK));
    for i =1:size(ls,1)
        barLength=dist(ps(ls(i,1),:),ps(ls(i,2),:));
        ks=A(i)*E/barLength;
        cosX=(ps(ls(i,2),1)-ps(ls(i,1),1))/barLength;
        cosY=(ps(ls(i,2),2)-ps(ls(i,1),2))/barLength;
        cosZ=(ps(ls(i,2),3)-ps(ls(i,1),3))/barLength;
        I=[ls(i,1)*3-2 ls(i,1)*3-1 ls(i,1)*3 ls(i,2)*3-2 ls(i,2)*3-1 ls(i,2)*3 ];
        V=[cosX cosY cosZ -cosX -cosY -cosZ];
        Kcos=sparse(I,1,V,lenK,1);
        K=K+Kcos*transpose(Kcos)*ks;
    end
end
 %{
    K=zeros(length(ps)*3);
    for i =1:size(ls,1)
        barLength=dist(ps(ls(i,1),:),ps(ls(i,2),:));
        ks=A(i)*E/barLength;
        cosX=(ps(ls(i,2),1)-ps(ls(i,1),1))/barLength;
        cosY=(ps(ls(i,2),2)-ps(ls(i,1),2))/barLength;
        cosZ=(ps(ls(i,2),3)-ps(ls(i,1),3))/barLength;
        Kcos=[zeros(ls(i,1)*3-3,1);cosX;cosY;cosZ;zeros(ls(i,2)*3-ls(i,1)*3-3,1);-cosX;-cosY;-cosZ;zeros(length(ps)*3-ls(i,2)*3,1)];
        %{
        Kcos=zeros(length(ps)*3,1);
        Kcos(ls(i,1)*3-2)=cosX;
        Kcos(ls(i,1)*3-1)=cosY;
        Kcos(ls(i,1)*3)=cosZ;
        Kcos(ls(i,2)*3-2)=-cosX;
        Kcos(ls(i,2)*3-1)=-cosY;
        Kcos(ls(i,2)*3)=-cosZ;
        %}
        K=K+Kcos*transpose(Kcos)*ks;
    end
%}   
