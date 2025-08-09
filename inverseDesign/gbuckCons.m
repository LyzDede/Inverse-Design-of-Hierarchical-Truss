function [c,ceq]=gbuckCons(lamb,Kaa,Gaa)
    ceq=[];
    
    kg=Kaa+Gaa*lamb;
    [vs,es]=eig(full(kg));
    u=diag(real(es))';
    c=[-u];%

end