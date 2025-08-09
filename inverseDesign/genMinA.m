function Ta = genMinA( F,k,L,loc,vtimes,fksa,tanGeosa,netA )

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
    
    sc=L/1000;
    subFK=[F/(sc*sc);k/sc];
    fkIn1246a=uniformFoward(log(fks1246a),log(subFK));
    fkIn18a=uniformFoward(log(fks18a),log(subFK));
        
    uniPre12a = sim(netA12,fkIn1246a);  
    preTanGeo12a=uniformBack(tanGeos12a,uniPre12a);
    preOriGeo12a=CalOriGeo(preTanGeo12a,12);

    uniPre14a = sim(netA14,fkIn1246a);  
    preTanGeo14a=uniformBack(tanGeos14a,uniPre14a);
    preOriGeo14a=CalOriGeo(preTanGeo14a,14);
        
    uniPre16a = sim(netA16,fkIn1246a);  
    preTanGeo16a=uniformBack(tanGeos16a,uniPre16a);
    preOriGeo16a=CalOriGeo(preTanGeo16a,16);
        
    uniPre18a = sim(netA18,fkIn18a);  
    preTanGeo18a=uniformBack(tanGeos18a,uniPre18a);
    preOriGeo18a=CalOriGeo(preTanGeo18a,18);
    
    vpsa=[0 0 0;L 0 0];
    x12a=preOriGeo12a';
    x12a=[x12a(1:13) x12a(14:27)*sc*sc];
    v12a=objV(x12a,12,vpsa);
        
    x14a=preOriGeo14a';
    x14a=[x14a(1:15) x14a(16:31)*sc*sc];
    v14a=objV(x14a,14,vpsa);
        
    x16a=preOriGeo16a';
    x16a=[x16a(1:17) x16a(18:35)*sc*sc];
    v16a=objV(x16a,16,vpsa);
        
    x18a=preOriGeo18a';
    x18a=[x18a(1:19) x18a(20:39)*sc*sc];
    v18a=objV(x18a,18,vpsa);
    
    xs={x12a, x14a, x16a, x18a};
    vs=[v12a v14a v16a v18a];
    ns=[12 14 16 18];
        
    minx=xs{vs==min(vs)};
    minn=ns(vs==min(vs));
    
    Ta=subTruss(loc,vtimes,minn,L,F,k,min(vs),minx);
end

