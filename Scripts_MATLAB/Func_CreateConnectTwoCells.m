function Func_CreateConnectTwoCells( SynStruct,CreateConnectTwoCellsFile )
%Func_CreateConnectTwoCells Summary of this function goes here
%   Detailed explanation goes here

    SynID = [];
    SynName = {};

    for i = 1:length(SynStruct)
        SynID(i) = SynStruct(i).ID;
        SynName(i) = {SynStruct(i).Name};
        SynCompartment(i) = {SynStruct(i).Compartment};
        SynPos(i) = SynStruct(i).Position;
    end

    FileID = fopen(CreateConnectTwoCellsFile,'w');

    fprintf(FileID,'objref file2,DAlist2\n'); 
	fprintf(FileID,...
        '\n\tfile2 = new File()\n\tfile2.ropen("DA.txt")\n\tDAlist2 = new Vector()\n\tDAlist2.scanf(file2)\n');	
    fprintf(FileID,...
        'proc ConnectTwoCells() { local targetid,sourceid,type,initW,delay,threshold localobj target,syn,nc,synlist,nclist\n\tsourceid = $1\n\ttargetid = $2\n\ttype = $3\n\tinitW = $4\n\tdelay = $5\n\tthreshold = $6\n\tsynlist = $o7\n\tnclist = $o8\n');

    fprintf(FileID,...
        '\n\tif (pc.gid_exists(targetid)) {\n\t\ttarget = pc.gid2cell(targetid)\n');

    for i = SynID
        fprintf(FileID,'\t\tif (type == %d) {target.%s syn = new %s(0%d)}\n',...
            i,char(SynCompartment(SynID==i)),char(SynName(SynID==i)),SynPos(SynID==i));
    end
    
    fprintf(FileID,'\n\t\tsyn.pregid = sourceid\n\t\tsyn.postgid = targetid\n\t\tsyn.initW = initW\n\t\tnc = pc.gid_connect(sourceid,syn)\n\t\tnc.weight = 1\n\t\tnc.delay = delay\n\t\tnc.threshold = threshold\n');
    fprintf(FileID,'\tfor k=0, DAlist2.size-1 {\n\tif(targetid==DAlist2.x[k]) {\n\tsyn.neuroM = 1\n\t}\n}\n\t\tsynlist.append(syn)\n\t\tnclist.append(nc)\n');   
    fprintf(FileID,'\t}\n}');

    fclose(FileID);

end