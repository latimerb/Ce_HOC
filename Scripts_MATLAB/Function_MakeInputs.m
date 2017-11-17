function Function_MakeInputs( InputStruct,MakeInputsFile,InputDataDir )
%FUNCTION_MAKEINPUTS Summary of this function goes here
%   Detailed explanation goes here

    InputID = [];
    InputName = {};
    InputNum = [];

    for i = 1:length(InputStruct)
        InputID(i) = InputStruct(i).ID;
        InputName(i) = {InputStruct(i).Name};
        InputNum(i) = InputStruct(i).RecNumber;
    end
    
    FileID = fopen(MakeInputsFile,'w');
    
		fprintf(FileID,...
        'obfunc MakeInputs() { ');
    fprintf(FileID,...
        'local i \n');
    fprintf(FileID,'\tstrdef LocalInputFile\n');
    fprintf(FileID,'\tLocalInputList = new List()\n');
    fprintf(FileID,'\t\n');
	for i = 1:length(InputID)
        temp_name = char(InputName(i));
			fprintf(FileID,...
        '\n %s%d()\n',temp_name,i);	
	end
    fprintf(FileID,'\treturn LocalInputList\n}');

    
    for i = 1:length(InputID)
        max_idx = InputNum(i);
        temp_name = char(InputName(i));
	fprintf(FileID,...
        '\nproc %s%d() { local i localobj LocalInputVector,LocalFileObj\n',temp_name,i);	
        for j = 1:max_idx
            fprintf(FileID,'\tLocalInputFile = "%sInput_%s%d.dat"\n',InputDataDir,temp_name,j);
            fprintf(FileID,'\tLocalFileObj = new File()\n');
            fprintf(FileID,'\tLocalFileObj.ropen(LocalInputFile)\n');
            fprintf(FileID,'\tLocalInputVector = new Vector()\n');
            fprintf(FileID,'\tLocalInputVector.scanf(LocalFileObj)\n');
            fprintf(FileID,'\tLocalInputList.append(LocalInputVector)\n');
            fprintf(FileID,'\tLocalFileObj.close()\n');
            fprintf(FileID,'\t\n');
        end
			fprintf(FileID,...
        '} \n');	
    end
    
    
    fclose(FileID);
end

