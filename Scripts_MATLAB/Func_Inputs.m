function InputStruct = Func_Inputs( ModelXLSFileName,InputSheetName,InputFile )
%FUNC_INPUTS loads xls Inputs sheet and write datas into a txt ascii file.
%   No detailed explanation

[~,~,raw] = xlsread(ModelXLSFileName,InputSheetName);
FieldNames = raw(1,:);
RawDatas = raw(2:end,:);
InputStruct = cell2struct(RawDatas, FieldNames, 2);

FileID = fopen(InputFile,'w');
for CellInputID = 0:length(InputStruct)-1
    fprintf(FileID,'\t%d\t%s\t%d\t%d\t%d\n',InputStruct(CellInputID+1).ID,...
        InputStruct(CellInputID+1).Name,...
        InputStruct(CellInputID+1).RecNumber,...
        InputStruct(CellInputID+1).IntraLock,...
        InputStruct(CellInputID+1).UltraLock);
end
fclose(FileID);

end