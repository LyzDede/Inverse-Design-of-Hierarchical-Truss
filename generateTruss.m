
E=100000;
L=1000;

H2T6 = genH2(6,fksb,fksTest,netA,netB,tanGeosb,fksa,tanGeosa);
H2T8 = genH2(8,fksb,fksTest,netA,netB,tanGeosb,fksa,tanGeosa);
H2T10 = genH2(10,fksb,fksTest,netA,netB,tanGeosb,fksa,tanGeosa);
H2T12 = genH2(12,fksb,fksTest,netA,netB,tanGeosb,fksa,tanGeosa);

minN=[];

fkb1=[];
fkb2=[];
fka=[];

minV1=[];
minV2=[];
Va=[];
H2Tmin={};

h1or2=zeros(1,length(H2T6));
h2Num=zeros(1,length(H2T6));

for i=1:length(H2T6)
    
    F=H2T6{i}{1}.force;
    k=H2T6{i}{1}.stiffness;
    
    vs=[totalTrussV(H2T6{i}) totalTrussV(H2T8{i}) totalTrussV(H2T10{i}) totalTrussV(H2T12{i})];
    ns=[6 8 10 12];
    
    minn=ns(vs==min(vs));
    minN=[minN minn];
    HTminx=eval(strcat('H2T',num2str(minn)));
    H2Tmin{end+1}=HTminx{i};

    Tx=eval(strcat('H2T',num2str(minn)));
    if length(Tx{i})>1
        fkb1=[fkb1;F, k];
        minV1=[minV1 min(vs)];
    else
        fkb2=[fkb2;F, k];
        minV2=[minV2 min(vs)];
    end
    
    if k/E>2*sqrt(F/(pi*E))/15;
        fka=[fka;F, k];
        Ta = genMinA( F,k,L,1,1,fksa,tanGeosa,netA );
        Tav=Ta.volume;
        Va=[Va Tav];
        if Tav<min(vs) || length(Tx{i})==1
            h1or2(i)=1;
        else
            h1or2(i)=2;
            h2Num(i)=minn;
        end
    else
        h1or2(i)=2;
        h2Num(i)=minn;
    end
end



H3T6 = genH3(6,fksb,fksTestH3,netA,netB,tanGeosb,fksa,tanGeosa,h1or2,h2Num,fk);
H3T8 = genH3(8,fksb,fksTestH3,netA,netB,tanGeosb,fksa,tanGeosa,h1or2,h2Num,fk);
H3T10 = genH3(10,fksb,fksTestH3,netA,netB,tanGeosb,fksa,tanGeosa,h1or2,h2Num,fk);
H3T12 = genH3(12,fksb,fksTestH3,netA,netB,tanGeosb,fksa,tanGeosa,h1or2,h2Num,fk);

H3Tmin={};
for i=1:length(H3T6)
    
    F=H3T6{i}{1}.force;
    k=H3T6{i}{1}.stiffness;
    
    vs=[totalTrussV(H3T6{i}) totalTrussV(H3T8{i}) totalTrussV(H3T10{i}) totalTrussV(H3T12{i})];
    ns=[6 8 10 12];
    
    minn=ns(vs==min(vs));
    minN=[minN minn];
    HTminx=eval(strcat('H3T',num2str(minn)));
    H3Tmin{end+1}=HTminx{i};

end



