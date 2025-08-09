function HT = genH3(iniN,fksb,fksTestH3,netA,netB,tanGeosb,fksa,tanGeosa,h1or2,h2Num,fk)
    
    E=100000;
    iniL=1000;

    tanGeos6b=tanGeosb{1};
    tanGeos8b=tanGeosb{2};
    tanGeos10b=tanGeosb{3};
    tanGeos12b=tanGeosb{4};
    netB6=netB{1};
    netB8=netB{2};
    netB10=netB{3};
    netB12=netB{4};

    if iniN ==12
        fksxb=fksb{2};
    else
        fksxb=fksb{1};
    end

    E=100000;
    L=1000;
    fkIn=uniformFoward(log(fksxb),log(fksTestH3'));
    vps=[0 0 0;iniL 0 0];

    netx=eval(strcat('netB',num2str(iniN)));
    tanGeosX=eval(strcat('tanGeos',num2str(iniN),'b'));
    
    uniPre = sim(netx,fkIn);  
    preTanGeo=uniformBack(tanGeosX,uniPre);
    preOriGeo=CalOriGeo(preTanGeo,iniN);
    
    HT={};
    for i=1:length(fksTestH3)
        F=fksTestH3(i,1);
        k=fksTestH3(i,2);
        
        T={};
        x0=preOriGeo(:,i)';
        v0=objV(x0,iniN,vps);
        T{end+1}=subTruss(1,1, iniN,L,F,k,v0,x0);
        
        [ks,lens,Fs,addAs,vs1,vs2,lsnum,totalV]=nextGen(iniL,x0,iniN,F,E);
        T{end}.replaceNum=lsnum;
        if ks
            for j=1:length(ks)
                loc=[1,lsnum(j)];
                if lsnum(j)<9*iniN+9
                    vtms=12;
                else
                    vtms=6;
                end
                Ttemp = genMinHier2( Fs(j),ks(j),lens(j),loc,vtms,fk,h1or2,h2Num,fksa,tanGeosa,netA,fksb,tanGeosb,netB);
                T=horzcat(T,Ttemp);
            end
        end
        HT{end+1}=T;
    
    end

end
