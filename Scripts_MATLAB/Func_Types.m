function TypeStruct = Func_Types( ModelXLSFileName,TypeSheetName,TypeFile )
%FUNC_TYPES loads xls Types sheet and write datas into a txt ascii file.
%   No detailed explanation

[~,~,raw] = xlsread(ModelXLSFileName,TypeSheetName);
FieldNames = raw(1,:);
RawDatas = raw(2:end,:);
TypeStruct = cell2struct(RawDatas, FieldNames, 2);

FileID = fopen(TypeFile,'w');
for CellTypeID = 0:length(TypeStruct)-1
    fprintf(FileID,'\t%d\t%s\t%d\t%f\n',TypeStruct(CellTypeID+1).ID,...
        TypeStruct(CellTypeID+1).Name,TypeStruct(CellTypeID+1).CellNumber,...
        TypeStruct(CellTypeID+1).Vinit);
end
fclose(FileID);

end