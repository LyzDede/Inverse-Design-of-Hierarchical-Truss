load("net\A_topo12_layNum20_logFK_tangGeo_lowF.mat")
load("net\A_topo14_layNum25_logFK_tangGeo_lowF.mat")
load("net\A_topo16_layNum30_logFK_tangGeo_lowF.mat")
load("net\A_topo18_layNum32_logFK_tangGeo_lowF.mat")
load("net\topo6_layNum14_logFK_tangGeo_lowF.mat")
load("net\topo8_layNum19_logFK_tangGeo_lowF.mat")
load("net\topo10_layNum20_logFK_tangGeo_lowF.mat")
load("net\topo12_layNum24_logFK_tangGeo_lowF.mat")

load("Hier\hier3\fksH3.mat")
load("Hier\hier2\fk.mat")

filename='optData\b6.xlsx';
data = xlsread(filename);
n=6;
fklNum=linspace(1,2713,679);  %8b
geoNum=linspace(2,2714,679);
fks6b=data(fklNum,2:3)';
geos=data(geoNum,:)';
tanGeos6b =CalTanGeo(geos,n);

filename='optData\b8.xlsx';
data = xlsread(filename);
fks8b=data(fklNum,2:3)';
n=8;
geos=data(geoNum,:)';
tanGeos8b =CalTanGeo(geos,n);

filename='optData\b10.xlsx';
data = xlsread(filename);
fks10b=data(fklNum,2:3)';
n=10;
geos=data(geoNum,:)';
tanGeos10b =CalTanGeo(geos,n);

filename='optData\b12.xlsx';
data = xlsread(filename);
n=12;
fklNum=linspace(1,2701,676);    %12b
geoNum=linspace(2,2702,676);
fks12b=data(fklNum,2:3)';
geos=data(geoNum,:)';
tanGeos12b =CalTanGeo(geos,n);


filename='optData\a12.xlsx';
data = xlsread(filename);
n=12;
fklNum=linspace(1,1537,385);  %a 12 14 16
geoNum=linspace(2,1538,385);
fks12a=data(fklNum,2:3)';
geos12=data(geoNum,:)';
tanGeos12a =CalTanGeo(geos12,n);

filename='optData\a14.xlsx';
data = xlsread(filename);
n=14;
fks14a=data(fklNum,2:3)';
geos14=data(geoNum,:)';
tanGeos14a =CalTanGeo(geos14,n);

filename='optData\a16.xlsx';
data = xlsread(filename);
fks16a=data(fklNum,2:3)';
n=16;
geos16=data(geoNum,:)';
tanGeos16a =CalTanGeo(geos16,n);

filename='optData\a18.xlsx';
data = xlsread(filename);
n=18;
fklNum=linspace(1,1525,382);  %a 18
geoNum=linspace(2,1526,382);
fks18a=data(fklNum,2:3)';
geos18=data(geoNum,:)';
tanGeos18a =CalTanGeo(geos18,n);

fksa={fks12a,fks18a};
tanGeosa={tanGeos12a,tanGeos14a,tanGeos16a,tanGeos18a};
netA={netA12,netA14,netA16,netA18};
fksb={fks6b,fks8b,fks10b,fks12b};
tanGeosb={tanGeos6b,tanGeos8b,tanGeos10b,tanGeos12b};
netB={netB6,netB8,netB10,netB12};

fkIn=uniformFoward(log(fks12b),log(fks12b));
geoOut=uniformFoward(tanGeos12b,tanGeos12b);

