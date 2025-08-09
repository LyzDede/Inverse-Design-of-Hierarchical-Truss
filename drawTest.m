%{
num=1;  %% 1<num<length(H2Tmin)
if length(H2Tmin{num})>1
    [ps2,ls2,As2,repls2]=drawTrussH2(H2Tmin{num});
else
    [ps1,ls1,As1]=drawTrussH1(H2Tmin{num});
end
%}

num=530;  %% 1<num<length(H3Tmin)
truehier=1;
for i=1:length(H3Tmin{num})
    if length(H3Tmin{num}{i}.location)>truehier
        truehier=length(H3Tmin{num}{i}.location);
    end
end

if truehier==1
    [ps1,ls1,As1]=drawTrussH1(H3Tmin{num});
elseif truehier==2
    [ps2,ls2,As2,repls2]=drawTrussH2(H3Tmin{num});
else
    [ps3,ls3,As3,repls3]=drawTrussH3(H3Tmin{num});
end
