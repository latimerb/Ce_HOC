function Func_CreateSynapses( SynStruct,CreateSynapsesFile )
%FUNC_CREATESYNAPSES Summary of this function goes here
%   Detailed explanation goes here

    SynID = [];
    SynName = {};

    for i = 1:length(SynStruct)
        SynID(i) = SynStruct(i).ID;
        SynName(i) = {SynStruct(i).Name};
        SynCompartment(i) = {SynStruct(i).Compartment};
        SynPos(i) = SynStruct(i).Position;
    end

    FileID = fopen(CreateSynapsesFile,'w');
    
    fprintf(FileID,...
        'obfunc CreateSynapses() { local i localobj SynObj\n\ti = $1\n');

    for i = SynID
        fprintf(FileID,'\tif(i==%d) {SynObj = new %s(%f)}\n',...
            i,char(SynName(SynID==i)),SynPos(SynID==i));
    end
    
    fprintf(FileID,'\treturn SynObj\n}');

    fclose(FileID);

end

