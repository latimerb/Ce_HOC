function Func_CreateEachType( TypeStruct,CreateEachTypeFile )

    TypeCellID = [];
    TypeCellName = {};

    for i = 1:length(TypeStruct)
        TypeCellID(i) = TypeStruct(i).ID;
        TypeCellName(i) = {TypeStruct(i).Name};
    end

    FileID = fopen(CreateEachTypeFile,'w');
    
    fprintf(FileID,...
        'obfunc CreateEachType() { local i, j localobj CellObj\n\ti = $1\n\tj = $2\n');

    for i = TypeCellID
        fprintf(FileID,'\tif(i==%d) {CellObj = new %s(j)}\n',...
            i,char(TypeCellName(TypeCellID==i)));
    end
    
    fprintf(FileID,'\treturn CellObj\n}');

    fclose(FileID);

end
