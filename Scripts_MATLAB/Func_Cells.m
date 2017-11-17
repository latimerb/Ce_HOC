function CellStruct = Func_Cells( TypeStruct,GroupStruct,AllPositons,CellFile )
%FUNC_CELLS write cells datas into a txt ascii file
%   No detailed explanation

CellStruct = struct([]);
CellID = 0;

Cells = 0;
for i = 1:length(TypeStruct)
    Cells = Cells + TypeStruct(i).CellNumber;
end 
	c=1; m=1;

for i=1:size(AllPositons,1)
    if(AllPositons(i,1)>7.1 && AllPositons(i,1)<=7.9)  % points on bregma for sepration x axis 
       if(AllPositons(i,2)>3.0 && AllPositons(i,2)<=4.4) % y axis
        cem(c,1:3)= AllPositons(i,1:3);
        c=c+1;
       else 
           cel(m,1:3) = AllPositons(i,1:3);
        m=m+1;
       end
    else
       cel(m,1:3) = AllPositons(i,1:3);
        m=m+1;
    end
end


	
for i = 1:length(GroupStruct)
	 CellNumberarrray = str2num(GroupStruct(i).CellNumber());
	  	if(i==1)
		INDFlag = zeros(size(cem,1),1);
		else
		INDFlag = zeros(size(cel,1),1);
		end
for k = 1:size(CellNumberarrray,2)
    GroupID = GroupStruct(i).ID;
	TypeID = k-1;
    CellNumber = CellNumberarrray(1,k);
    AvailableIND = find(INDFlag==0);
    NumAllPositions = size(AvailableIND,1);
        temp = randperm(NumAllPositions);
        temp = temp(1:CellNumber);
        IND(:,1) = AvailableIND(temp,1);
	if(i==1)
	    Pos = cem(IND,:);
		else
		Pos = cel(IND,:);
	end
        
        INDFlag(IND,1) = 1;
		
	
 
    for j = 1:CellNumber;
        CellStruct(CellID+1).ID = CellID;
        CellStruct(CellID+1).TypeID = TypeID;
        CellStruct(CellID+1).GroupID = GroupID;
        CellStruct(CellID+1).XPos = Pos(j,1);
        CellStruct(CellID+1).YPos = Pos(j,2);
        CellStruct(CellID+1).ZPos = Pos(j,3);
        CellID = CellID + 1;
    end
	
	
    clear temp IND Pos;
end
end
FileID = fopen(CellFile,'w');
for CellID = 0:length(CellStruct)-1
    fprintf(FileID,'\t%d\t%d\t%d\t%f\t%f\t%f\n',CellStruct(CellID+1).ID,...
        CellStruct(CellID+1).TypeID,CellStruct(CellID+1).GroupID,...
        CellStruct(CellID+1).XPos,CellStruct(CellID+1).YPos,...
        CellStruct(CellID+1).ZPos);
end
fclose(FileID);

end