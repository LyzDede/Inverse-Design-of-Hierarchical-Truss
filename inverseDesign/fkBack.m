function [newF,newK] =fkBack(predictGeo,oriF,n,E)
    newF=zeros(1,size(predictGeo,2));
    newK=zeros(1,size(predictGeo,2));
    for i=1:size(predictGeo,2)
        
        x=predictGeo(:,i)';
        a=floor(n/2)+1;
        b=floor((n + 1) / 2) + 1;
        ts=x(1:a);
        d=x(a+1:a+b-1);
        ds=[d 0.5-sum(d)];
        A=x2fullA(x,n);
        
        vps=[0 0 0; 1000 0 0];
        [ps,ls]=farMaoOpt(vps, n,ts,ds);
        K=stiffMatrix3D(ps, ls, A, E);
        
        F0=oriF(i);
        frees = [0, 0, 0, 0, 0, 0, 0, 1, 0,zeros(1,length(ps)*3-15),1, 1, 1, 0, 1, 1];
        Fa=[zeros(length(ps)*3-7,1);-F0];
        Uc=zeros(1,6);
        [U,F]=calFandU(K, frees, Fa, Uc);
        newK(i)=F0/abs(U(length(U)-2));
 
        G = geoStiffMatrix3D(ps, ls, A, E, U);
        Kaa = notFixMatrixG(K, frees);
        Gaa = notFixMatrixG(G, frees);
  %{     
        llb=0; lub=100;
        thre = -1e-6; 
        for loop = 1:100
           lam=(llb+lub)/2;
           mine= min(eig( Kaa+ lam*Gaa)) ;
           if thre < mine % positive matrix, good!
               llb=lam; % rise the low bound
               if 0.01 > abs(lub-llb) 
                 break
               end
           else     % negative matrix, bad
              lub=lam; % reduce the upper bound
           end    
        end
        newF(i)=lam*F0;
        %}
        %{  %}  
        x0=[1];
        lb=[0.01];
        ub=[20];
        options = optimoptions('fmincon');
        options.Display='iter';
        [lamb,fval,exitflag,output,lambda] =fmincon(@(lamb) -lamb,x0,[],[],[],[],lb,ub,@(lamb) gbuckCons(lamb,Kaa,Gaa),options)
         
        newF(i)=lamb*F0;
          
    end
end

