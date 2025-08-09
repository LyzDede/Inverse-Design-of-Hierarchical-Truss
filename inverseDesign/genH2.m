function HT = genH2(n,fksb,fksTest,netA,netB,tanGeosb,fksa,tanGeosa)

    E=100000;
    L=1000;

    tanGeos6b=tanGeosb{1};
    tanGeos8b=tanGeosb{2};
    tanGeos10b=tanGeosb{3};
    tanGeos12b=tanGeosb{4};
    netB6=netB{1};
    netB8=netB{2};
    netB10=netB{3};
    netB12=netB{4};

    if n==12
        fksxb=fksb{2};
    else
        fksxb=fksb{1};
    end

    fkIn=uniformFoward(log(fksxb),log(fksTest'));
    vps=[0 0 0;L 0 0];
    
    netx=netB{n/2-2};
    tanGeosX=eval(strcat('tanGeos',num2str(n),'b'));
    
    uniPre = sim(netx,fkIn);  
    preTanGeo=uniformBack(tanGeosX,uniPre);
    preOriGeo=CalOriGeo(preTanGeo,n);
    
    HT={};
    for i=1:length(fksTest)
        F=fksTest(i,1);
        k=fksTest(i,2);
        T={};
        x=preOriGeo(:,i)';
        v=objV(x,n,vps);
        T{end+1}=subTruss(1,1, n,L,F,k,v,x);
        
        [ks,lens,Fs,addAs,vs1,vs2,lsnum,totalV]=nextGen(L,x,n,F,E);
        T{end}.replaceNum=lsnum;
        if ks
            for j=1:length(ks)
                loc=[1,lsnum(j)];
                if lsnum(j)<9*n+9
                    vtms=12;
                else
                    vtms=6;
                end
                T{end+1} = genMinA( Fs(j),ks(j),lens(j),loc,vtms,fksa,tanGeosa,netA );
            end
    
        end
        HT{end+1}=T;
    
    end
end
