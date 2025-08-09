function [ps,ls,As]=drawTrussH1(T)
    vps=[0 0 0 ;T{1}.length 0 0];
    n=T{1}.topo;
    x=T{1}.xOpt;

    a=floor(n/2)+1;
    b=floor((n + 1) / 2) + 1;
    ts=x(1:a);
    d=x(a+1:a+b-1);
    ds=[d 0.5-sum(d)];
    [ps,ls]=farMaoOpt(vps, n,ts,ds);
    As=x2fullA(x,n);
    
    figure
    for i=1:length(ls)
        plot3([ps(ls(i,1),1) ps(ls(i,2),1)],[ps(ls(i,1),2) ps(ls(i,2),2)],[ps(ls(i,1),3) ps(ls(i,2),3)],'k','LineWidth',sqrt(As(i)/pi))
        hold on
    end
    axis equal
    v=totalTrussV(T);
    title(strcat('Truss Volume =',num2str(v),', Hierarchy = 1'));
end