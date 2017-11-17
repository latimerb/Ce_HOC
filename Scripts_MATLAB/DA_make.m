count = 1;
for i=0:259
    if rand()<=0.25
        DA(count,1) = i;
    count = count+1;
    end
end
for i=260:379
    if rand()<=0.5
        DA(count,1) = i;
    count = count+1;
    end
end
for i=380:499
    if rand()<=0.25
        DA(count,1) = i;
    count = count+1;
    end
end
save('DA.txt','DA','-ascii');