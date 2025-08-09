function numFK = findNearFK( fks,fk )
    lens=[];
    for i =1:length(fks)
        len=norm(fks(i,:)-fk);
        lens=[lens len];
    end
    numFK=find(lens==min(lens));
end

