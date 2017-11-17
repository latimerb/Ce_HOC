function [InternalConnSynMatrix,InternalConnThrMatrix,InternalConnWgtMatrix,...
    InternalConnDelMatrix] = Func_InternalConns(ModelXLSFileName,...
    InternalConnSheetName,CellStruct,InternalConnSynFile,...
    InternalConnThrFile,InternalConnDelFile,InternalConnWgtFile)
%FUNC_INTERNALCONN Summary of this function goes here
%   Detailed explanation goes here

    %%
    [~,~,raw] = xlsread(ModelXLSFileName,InternalConnSheetName);
    InternalConnCell = raw(2:end,2:end);

    %%
    TotalCellNumber = length(CellStruct);

    InternalConnSynMatrix = zeros(TotalCellNumber,TotalCellNumber);
    InternalConnThrMatrix = zeros(TotalCellNumber,TotalCellNumber);
    InternalConnWgtMatrix = zeros(TotalCellNumber,TotalCellNumber);
    InternalConnDelMatrix = zeros(TotalCellNumber,TotalCellNumber);

    %%
cellno = 0;
    for j = 1:size(InternalConnCell,2)
        PostGroupID = j-1;
        PostCellIndArray = find([CellStruct.GroupID]==PostGroupID);
        for i = 1:size(InternalConnCell,1)
            PreGroupID = i-1;
            PreCellIndArray = find([CellStruct.GroupID]==PreGroupID);
            PreNum = length(PreCellIndArray);
            ConnData = str2num(cell2mat(InternalConnCell(i,j)));
            P = ConnData(1);
            TempCell = {};
            TempTotal = [];
            synid = ConnData(2);
            synrandtype = ConnData(3);
            synrandvar1 = ConnData(4); synrandvar2 = ConnData(5);
            thr = ConnData(6);
            wgtrandtype = ConnData(7); wgtrandvar1 = ConnData(8); 
            wgtrandvar2 = ConnData(9);
            delrandtype = ConnData(10); delrandvar1 = ConnData(11); 
            delrandvar2 = ConnData(12);
            
            if (P>0)
                for k = 1:PreNum
                    PreID = CellStruct(PreCellIndArray(k)).ID;
                    PostCellIndArrayNow = PostCellIndArray(PostCellIndArray~=PreID+1);
                    TempArray = [];
                    PickNum = round(P*numel(PostCellIndArrayNow));
                    
                    if synrandtype == 1
                        if all(synrandvar1==0) && all(synrandvar2==0)
                           L = 1; U = numel(PostCellIndArrayNow);
							%for k=1:U
							%if(rand()<=P)
							%TempArray = PostCellIndArrayNow(1,k);
                            TempArray = PostCellIndArrayNow(1,round((L + (U-L).*rand(PickNum,1))))';
                            
                            TempCell(end+1) = {TempArray};
                            
                            if (~isempty(TempArray))
                                for m = 1:length(TempArray)
                                    TempCellID = CellStruct(TempArray(m)).ID;
                                   
								 InternalConnSynMatrix(PreID+1,...
                                        TempCellID+1) = synid;
                                    InternalConnThrMatrix(PreID+1,...
                                        TempCellID+1) = thr;
                                    if wgtrandtype == 1
                                        L = wgtrandvar1; U = wgtrandvar2;
                                        InternalConnWgtMatrix(PreID+1,...
                                        TempCellID+1) = ((L + (U-L).*...
                                        rand()));
                                    end
                                    if wgtrandtype == 2
                                        mu = wgtrandvar1; sigma = wgtrandvar2;
                                        InternalConnWgtMatrix(PreID+1,...
                                        TempCellID+1) = mu + sigma*randn();
                                    end
                                    if delrandtype == 1
                                        L = delrandvar1; U = delrandvar2;
                                        InternalConnDelMatrix(PreID+1,...
                                        TempCellID+1) = ((L + (U-L).*...
                                        rand()));
                                    end
                                    if delrandtype == 2
                                        mu = delrandvar1; sigma = delrandvar2;
                                        InternalConnDelMatrix(PreID+1,...
                                        TempCellID+1) = mu + sigma*randn();
                                    end
                                end
                            %end
							%end
							end
                        end
                    end
                    
                    if synrandtype == 2
                        if all(synrandvar1==0) && all(synrandvar2==0)
                            L = 1; U = numel(PostCellIndArrayNow);
							%for k=1:U
							%if(rand()<=P)
							%TempArray = PostCellIndArrayNow(1,k);
                            TempArray = PostCellIndArrayNow(1,round((L + (U-L).*rand(PickNum,1))))';
                            
                            TempCell(end+1) = {TempArray};
                            if (~isempty(TempArray))
                                for m = 1:length(TempArray)
                                    TempCellID = CellStruct(TempArray(m)).ID;
                                   
								 InternalConnSynMatrix(PreID+1,...
                                        TempCellID+1) = synid;
                                    InternalConnThrMatrix(PreID+1,...
                                        TempCellID+1) = thr;
                                    if wgtrandtype == 1
                                        L = wgtrandvar1; U = wgtrandvar2;
                                        InternalConnWgtMatrix(PreID+1,...
                                        TempCellID+1) = ((L + (U-L).*...
                                        rand()));
                                    end
                                    if wgtrandtype == 2
                                        mu = wgtrandvar1; sigma = wgtrandvar2;
                                        InternalConnWgtMatrix(PreID+1,...
                                        TempCellID+1) = mu + sigma*randn();
                                    end
                                    if delrandtype == 1
                                        L = delrandvar1; U = delrandvar2;
                                        InternalConnDelMatrix(PreID+1,...
                                        TempCellID+1) = ((L + (U-L).*...
                                        rand()));
                                    end
                                    if delrandtype == 2
                                        mu = delrandvar1; sigma = delrandvar2;
                                        InternalConnDelMatrix(PreID+1,...
                                        TempCellID+1) = mu + sigma*randn();
                                    end
                                end
                            end
                        end
                    end
                    
                    if synrandtype == 3
                        if all(synrandvar1~=0) && all(synrandvar2==0)
                            prex = CellStruct(PreID).XPos;
                            prey = CellStruct(PreID).YPos;
                            prez = CellStruct(PreID).ZPos;
                            postx = [CellStruct(PostCellIndArrayNow).XPos];
                            posty = [CellStruct(PostCellIndArrayNow).YPos];
                            postz = [CellStruct(PostCellIndArrayNow).ZPos];
                            DistArray = sqrt((postx-prex).^2+(posty-prey).^2+(postz-prez).^2);
                            TempArray = find(DistArray<synrandvar1);
                            TempCell(end+1) = {TempArray};
                            if (~isempty(TempArray))
                                for m = 1:length(TempArray)
                                    TempCellID = CellStruct(TempArray(m)).ID;
                                    InternalConnSynMatrix(PreID+1,...
                                        TempCellID+1) = synid;
                                    InternalConnThrMatrix(PreID+1,...
                                        TempCellID+1) = thr;
                                    if wgtrandtype == 1
                                        L = wgtrandvar1; U = wgtrandvar2;
                                        InternalConnWgtMatrix(PreID+1,...
                                        TempCellID+1) = ((L + (U-L).*...
                                        rand()));
                                    end
                                    if wgtrandtype == 2
                                        mu = wgtrandvar1; sigma = wgtrandvar2;
                                        InternalConnWgtMatrix(PreID+1,...
                                        TempCellID+1) = mu + sigma*randn();
                                    end
                                    if delrandtype == 1
                                        L = delrandvar1; U = delrandvar2;
                                        InternalConnDelMatrix(PreID+1,...
                                        TempCellID+1) = ((L + (U-L).*...
                                        rand()));
                                    end
                                    if delrandtype == 2
                                        mu = delrandvar1; sigma = delrandvar2;
                                        InternalConnDelMatrix(PreID+1,...
                                        TempCellID+1) = mu + sigma*randn();
                                    end
                                end
                            end
                        end
                    end
                    
                    if synrandtype == 4
                        if all(synrandvar1~=0) && all(synrandvar2==0)
                            prex = CellStruct(PreID).XPos;
                            prey = CellStruct(PreID).YPos;
                            prez = CellStruct(PreID).ZPos;
                            postx = [CellStruct(PostCellIndArrayNow).XPos];
                            posty = [CellStruct(PostCellIndArrayNow).YPos];
                            postz = [CellStruct(PostCellIndArrayNow).ZPos];
                            DistArray = sqrt((postx-prex).^2+(posty-prey).^2+(postz-prez).^2);
                            TempArray = find(DistArray<synrandvar1);
                            TempCell(end+1) = {TempArray};
                            if (~isempty(TempArray))
                                for m = 1:length(TempArray)
                                    TempCellID = CellStruct(TempArray(m)).ID;
                                    InternalConnSynMatrix(PreID+1,...
                                        TempCellID+1) = synid;
                                    InternalConnThrMatrix(PreID+1,...
                                        TempCellID+1) = thr;
                                    if wgtrandtype == 1
                                        L = wgtrandvar1; U = wgtrandvar2;
                                        InternalConnWgtMatrix(PreID+1,...
                                        TempCellID+1) = round((L + (U-L).*...
                                        rand()));                                    
                                    
                                        L = wgtrandvar1-7; U = wgtrandvar2-8;
                                        InternalConnWgtMatrix(TempCellID+1,...
                                            PreID+1) = round((L + (U-L).*...
                                            rand()));
                                    end
                                    if wgtrandtype == 2
                                        mu = wgtrandvar1; sigma = wgtrandvar2;
                                        InternalConnWgtMatrix(PreID+1,...
                                        TempCellID+1) = mu + sigma*randn();
                                    end
                                    if delrandtype == 1
                                        L = delrandvar1; U = delrandvar2;
                                        InternalConnDelMatrix(PreID+1,...
                                        TempCellID+1) = round((L + (U-L).*...
                                        rand()));
%                                         L = delrandvar1; U = delrandvar2;
%                                         InternalConnDelMatrix(TempCellID+1,...
%                                         PreID+1) = round((L + (U-L).*...
%                                         rand()));
                                        InternalConnDelMatrix(TempCellID+1,...
                                        PreID+1) = InternalConnDelMatrix(PreID+1,...
                                        TempCellID+1);
                                    end
                                    if delrandtype == 2
                                        mu = delrandvar1; sigma = delrandvar2;
                                        InternalConnDelMatrix(PreID+1,...
                                        TempCellID+1) = mu + sigma*randn();
                                        mu = delrandvar1; sigma = delrandvar2;
                                        InternalConnDelMatrix(TempCellID+1,...
                                        PreID+1) = mu + sigma*randn();
                                    end
                                    
%                                     mu = 3; sigma = 1;
%                                     InternalConnWgtMatrix(TempCellID+1,...
%                                         PreID+1) = mu + sigma*randn();
%                                     
%                                     mu = 3; sigma = 1;
%                                     InternalConnDelMatrix(TempCellID+1,...
%                                         PreID+1) = mu + sigma*randn();
                                end
                            end
                        end
                    end
                    if synrandtype == 5
                        if all(synrandvar1==0) && all(synrandvar2==0)
                            L = 1; U = numel(PostCellIndArrayNow);
							%for k=1:U
							%if(rand()<=P)
							%TempArray = PostCellIndArrayNow(1,k);
                            TempArray = PostCellIndArrayNow(1,round((L + (U-L).*rand(PickNum,1))))';
                           
                            TempCell(end+1) = {TempArray};
                            if (~isempty(TempArray))
                                for m = 1:length(TempArray)
                                    TempCellID = CellStruct(TempArray(m)).ID;
                                   
								 InternalConnSynMatrix(PreID+1,...
                                        TempCellID+1) = synid;
                                    InternalConnThrMatrix(PreID+1,...
                                        TempCellID+1) = thr;
                                    if wgtrandtype == 1
                                        L = wgtrandvar1; U = wgtrandvar2;
                                        InternalConnWgtMatrix(PreID+1,...
                                        TempCellID+1) = ((L + (U-L).*...
                                        rand()));
                                    end
                                    if wgtrandtype == 2
                                        mu = wgtrandvar1; sigma = wgtrandvar2;
                                        InternalConnWgtMatrix(PreID+1,...
                                        TempCellID+1) = mu + sigma*randn();
                                    end
                                    if delrandtype == 1
                                        L = delrandvar1; U = delrandvar2;
                                        InternalConnDelMatrix(PreID+1,...
                                        TempCellID+1) = ((L + (U-L).*...
                                        rand()));
                                    end
                                    if delrandtype == 2
                                        mu = delrandvar1; sigma = delrandvar2;
                                        InternalConnDelMatrix(PreID+1,...
                                        TempCellID+1) = mu + sigma*randn();
                                    end
                                end
                            %end
							%end
							end
                        end
                    end                 
				 
                end
            end
        end


cellno = cellno + numel(PostCellIndArray);
    end
    
%%
% InternalConnWgtMatrix((InternalConnWgtMatrix<1)&(InternalConnWgtMatrix~=0)) = 1;
% InternalConnWgtMatrix = round(InternalConnWgtMatrix);
%InternalConnDelMatrix((InternalConnDelMatrix<1)&(InternalConnDelMatrix~=0)) = 1;
%InternalConnDelMatrix = round(InternalConnDelMatrix);
%%
FileID = fopen(InternalConnSynFile,'w');
for i = 1:size(InternalConnSynMatrix,1)
	for j = 1:size(InternalConnSynMatrix,2)
		fprintf(FileID,'\t%d',InternalConnSynMatrix(i,j));
	end
	fprintf(FileID,'\n');
end
fclose(FileID);

FileID = fopen(InternalConnThrFile,'w');  
for i = 1:size(InternalConnThrMatrix,1)                  
        for j = 1:size(InternalConnThrMatrix,2)
                fprintf(FileID,'\t%d',InternalConnThrMatrix(i,j));
        end
        fprintf(FileID,'\n');           
end
fclose(FileID);

FileID = fopen(InternalConnWgtFile,'w');  
for i = 1:size(InternalConnWgtMatrix,1)                  
        for j = 1:size(InternalConnWgtMatrix,2)
                fprintf(FileID,'\t%f',InternalConnWgtMatrix(i,j));
        end
        fprintf(FileID,'\n');           
end
fclose(FileID);

FileID = fopen(InternalConnDelFile,'w');  
for i = 1:size(InternalConnDelMatrix,1)                  
        for j = 1:size(InternalConnDelMatrix,2)
                fprintf(FileID,'\t%f',InternalConnDelMatrix(i,j));
        end
        fprintf(FileID,'\n');           
end
fclose(FileID);
