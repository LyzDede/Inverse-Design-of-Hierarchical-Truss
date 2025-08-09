function T = genMinHier2( F,k,L,loc,vtimes,fks,h1or2,h2Num,fksa,tanGeosa,netA,fksb,tanGeosb,netB  )
    E=100000;
    
    fks1246a=fksa{1};
    fks18a=fksa{2};
    tanGeos12a=tanGeosa{1};
    tanGeos14a=tanGeosa{2};
    tanGeos16a=tanGeosa{3};
    tanGeos18a=tanGeosa{4};
    netA12=netA{1};
    netA14=netA{2};
    netA16=netA{3};
    netA18=netA{4};
   
    %{
    fks6b=fksb{1};
    fks8b=fksb{1};
    fks10b=fksb{1};
    fks12b=fksb{2};
    tanGeos6b=tanGeosb{1};
    tanGeos8b=tanGeosb{2};
    tanGeos10b=tanGeosb{3};
    tanGeos12b=tanGeosb{4};
    netB6=netB{1};
    netB8=netB{2};
    netB10=netB{3};
    netB12=netB{4};
    %}
    
    sc=L/1000;
    subFK=[F/(sc*sc);k/sc];
    numFK = findNearFK( fks,subFK' );
    if h1or2(numFK)==1
        T = {genMinA( F,k,L,loc,vtimes,fksa,tanGeosa,netA )};
        notFat=1;
    else
        n=h2Num(numFK);
        tanGeoIni=tanGeosb{n/2-2};
        fksIni=fksb{n/2-2};
        netb=netB{n/2-2};
        
        fkIn=uniformFoward(log(fksIni),log(subFK));
        uniPre = sim(netb,fkIn);  
        preTanGeo=uniformBack(tanGeoIni,uniPre);
        preOriGeo=CalOriGeo(preTanGeo,n);
        
        x=preOriGeo';
        x=[x(1:n+1) x(n+2:n*2+3)*sc*sc];
        vps=[0 0 0;L,0,0];
        v=objV(x,n,vps);
        
        T={};
        T{end+1}=subTruss(loc,vtimes, n,L,F,k,v,x);
        
        [ks,lens,Fs,addAs,vs1,vs2,lsnum,totalV]=nextGen(L,x,n,F,E);
        T{end}.replaceNum=lsnum;
        for j=1:length(ks)
            if lsnum(j)<9*n+9
                vtms=vtimes*12;
            else
                vtms=vtimes*6;
            end
            Tb=genMinA( Fs(j),ks(j),lens(j),[loc,lsnum(j)] ,vtms,fksa,tanGeosa,netA  );
            T{end+1} = Tb;
        end
    end
end

