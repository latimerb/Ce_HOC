function SynStruct = Func_Synapses( ModelXLSFileName,SynSheetName,SynFile )
%FUNC_TYPES loads xls Synapses sheet and write datas into a txt ascii file.
%   No detailed explanation

[~,~,raw] = xlsread(ModelXLSFileName,SynSheetName);
FieldNames = raw(1,:);
RawDatas = raw(2:end,:);
SynStruct = cell2struct(RawDatas, FieldNames, 2);

FileID = fopen(SynFile,'w');
for CellSynID = 0:length(SynStruct)-1
    fprintf(FileID,'\t%d\t%s\n',SynStruct(CellSynID+1).ID,...
        SynStruct(CellSynID+1).Name,SynStruct(CellSynID+1).Position,...
        SynStruct(CellSynID+1).Compartment);
end
fclose(FileID);

end