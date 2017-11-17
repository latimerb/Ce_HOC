function [InputConnSynMatrix,InputConnThrMatrix,InputConnWgtMatrix,...
    InputConnDelMatrix] = Func_InputConns( ModelXLSFileName,...
    InputConnSheetName,CellStruct,InputStruct,InputConnSynFile,...
    InputConnThrFile,InputConnDelFile,InputConnWgtFile )
%FUNC_INPUTCONNS loads xls InputConns sheet and write datas into a txt ascii file.
%   Detailed explanation goes here

%%
[~,~,raw] = xlsread(ModelXLSFileName,InputConnSheetName);
InputConnCell = raw(2:end,2:end); %%InputConnCell is the input connection sheet with probability, etc.

%%
TotalCellNumber = length(CellStruct); %%CellStruct is Data_Cells.txt
TotalInputRecNumber = sum([InputStruct.RecNumber]); %%InputStruct is Data_Inputs.txt
%%This number ^ should be the number of input connections

InputConnSynMatrix = zeros(TotalInputRecNumber,TotalCellNumber); %%Data_InputSynConns.txt
InputConnThrMatrix = zeros(TotalInputRecNumber,TotalCellNumber);
InputConnWgtMatrix = zeros(TotalInputRecNumber,TotalCellNumber);
InputConnDelMatrix = zeros(TotalInputRecNumber,TotalCellNumber);

%%
cellno = 0;
for j = 1:size(InputConnCell,2)
    GroupID = j-1;
    GroupIndexArray = find([CellStruct.GroupID]==GroupID); %%Make an array of one group (0, 1 or 2)
    InputRecID = 0;
    for i = 1:length(InputStruct)
        InputID = InputStruct(i).ID;
        InputNum = InputStruct(i).RecNumber;
        ConnData = str2num(cell2mat(InputConnCell(i,j)));
        P = ConnData(1); %%Probability of connection
        TempCell = {};
        TempTotal = [];
        synid = ConnData(2); synrandtype = ConnData(3);
        synrandvar1 = ConnData(4); synrandvar2 = ConnData(5);
        thr = ConnData(6);
        wgtrandtype = ConnData(7); wgtrandvar1 = ConnData(8); 
        wgtrandvar2 = ConnData(9);
        delrandtype = ConnData(10); delrandvar1 = ConnData(11); 
        delrandvar2 = ConnData(12);
   
            for k = 1:InputNum
                TempArray = [];
                PickNum = round(P*numel(GroupIndexArray)); %%P multiplied by the number of cells in the group
                
                if synrandtype == 1
                    if all(synrandvar1==0) && all(synrandvar2==0)
                        L = 1; U = numel(GroupIndexArray);
                        TempArray = cellno + round((L + (U-L).*rand(PickNum,1)));%%%%Makes 65 random numbers from 1:numel(GroupIndexArray)
%                         length(TempArray)
                        
                        TempCell(end+1) = {TempArray};%%%%Store TempArray in TempCell
                        TempTotal = [TempTotal,TempArray];
                        if (~isempty(TempArray))
                            for m = 1:length(TempArray)
                                TempCellID = CellStruct(TempArray(m)).ID;
								 InputConnSynMatrix(InputRecID+1,...
                                    TempArray(m)) = synid;
									
                                InputConnThrMatrix(InputRecID+1,...
                                    TempArray(m)) = thr;
                                if wgtrandtype == 1
                                    L = wgtrandvar1; U = wgtrandvar2;
                                    InputConnWgtMatrix(InputRecID+1,...
                                    TempArray(m)) = ((L + (U-L).*...
                                    rand()));
                                end
                                if wgtrandtype == 2
                                    mu = wgtrandvar1; sigma = wgtrandvar2;
                                    InputConnWgtMatrix(InputRecID+1,...
                                    TempArray(m)) = mu + sigma*randn();
                                end
                                if delrandtype == 1
                                    L = delrandvar1; U = delrandvar2;
                                    InputConnDelMatrix(InputRecID+1,...
                                    TempArray(m)) = ((L + (U-L).*...
                                    rand()));
                                end
                                if delrandtype == 2
                                    mu = delrandvar1; sigma = delrandvar2;
                                    InputConnDelMatrix(InputRecID+1,...
                                    TempArray(m)) = mu + sigma*randn();
                                end
                            end
                        end
                    end
                end
				if synrandtype == 5
				if all(synrandvar1==0) && all(synrandvar2==0)
                        L = 1; U = numel(GroupIndexArray);
                        TempArray = cellno + round((L + (U-L).*rand(PickNum,1)));%%%%Makes 65 random numbers from 1:numel(GroupIndexArray)
%                         length(TempArray)
                        
                        TempCell(end+1) = {TempArray};%%%%Store TempArray in TempCell
                        TempTotal = [TempTotal,TempArray];
                        if (~isempty(TempArray))
                            for m = 1:length(TempArray)
                                TempCellID = CellStruct(TempArray(m)).ID;
								 InputConnSynMatrix(InputRecID+1,...
                                    TempArray(m)) = synid;
									
                                InputConnThrMatrix(InputRecID+1,...
                                    TempArray(m)) = thr;
                                if wgtrandtype == 1
                                    L = wgtrandvar1; U = wgtrandvar2;
                                    InputConnWgtMatrix(InputRecID+1,...
                                    TempArray(m)) = ((L + (U-L).*...
                                    rand()));
                                end
                                if wgtrandtype == 2
                                    mu = wgtrandvar1; sigma = wgtrandvar2;
                                    InputConnWgtMatrix(InputRecID+1,...
                                    TempArray(m)) = mu + sigma*randn();
                                end
                                if delrandtype == 1
                                    L = delrandvar1; U = delrandvar2;
                                    InputConnDelMatrix(InputRecID+1,...
                                    TempArray(m)) = ((L + (U-L).*...
                                    rand()));
                                end
                                if delrandtype == 2
                                    mu = delrandvar1; sigma = delrandvar2;
                                    InputConnDelMatrix(InputRecID+1,...
                                    TempArray(m)) = mu + sigma*randn();
                                end
                            end
                        end
                    end
				
				
				end
                InputRecID = InputRecID + 1;
            end
      
    end
	cellno = cellno + numel(GroupIndexArray)
end

%%
% InputConnWgtMatrix((InputConnWgtMatrix<1)&(InputConnWgtMatrix~=0)) = 1;
% InputConnWgtMatrix = round(InputConnWgtMatrix);
%InputConnDelMatrix((InputConnDelMatrix<1)&(InputConnDelMatrix~=0)) = 1;
%InputConnDelMatrix = round(InputConnDelMatrix);

%%
FileID = fopen(InputConnSynFile,'w');
for i = 1:size(InputConnSynMatrix,1)
	for j = 1:size(InputConnSynMatrix,2)
		fprintf(FileID,'\t%d',InputConnSynMatrix(i,j));
	end
	fprintf(FileID,'\n');
end
fclose(FileID);

FileID = fopen(InputConnThrFile,'w');  
for i = 1:size(InputConnThrMatrix,1)                  
        for j = 1:size(InputConnThrMatrix,2)
                fprintf(FileID,'\t%d',InputConnThrMatrix(i,j));
        end
        fprintf(FileID,'\n');           
end
fclose(FileID);

FileID = fopen(InputConnWgtFile,'w');  
for i = 1:size(InputConnWgtMatrix,1)                  
        for j = 1:size(InputConnWgtMatrix,2)
                fprintf(FileID,'\t%f',InputConnWgtMatrix(i,j));
        end
        fprintf(FileID,'\n');           
end
fclose(FileID);

FileID = fopen(InputConnDelFile,'w');  
for i = 1:size(InputConnDelMatrix,1)                  
        for j = 1:size(InputConnDelMatrix,2)
                fprintf(FileID,'\t%f',InputConnDelMatrix(i,j));
        end
        fprintf(FileID,'\n');           
end
fclose(FileID);

% RandPickArray = {[]};
% for j = 1:size(InputConnCell,2)
%     GroupID = j-1;
%     GroupIndexArray = find([CellStruct.GroupID]==GroupID);
%     InputRecID = 0;
%     for i = 1:size(InputConnCell,1)
%         InputID = i-1;
%         InputNum = InputStruct(i).RecNumber;
%         ConnData = str2num(cell2mat(InputConnCell(i,j)));
%         P = ConnData(1);
%         TempCell = {};
%         TempTotal = [];
%         if (P>0)
%             for k = 1:InputNum
%                 TempArray = [];
%                 TempArray = Func_RandArrayGen(GroupIndexArray,P);
%                 TempCell(end+1) = {TempArray};
%                 TempTotal = [TempTotal,TempArray];
%                 if (~isempty(TempArray))
%                     for m = 1:length(TempArray)
%                         TempCellID = CellStruct(TempArray(m)).ID;
%                         TempInputRecID = InputRecID;
%                         InputConnSynMatrix(InputRecID+1,TempArray(m)) =...
%                             ConnData(2);
%                         InputConnThrMatrix(InputRecID+1,TempArray(m)) =...
%                             ConnData(3);
%                         InputConnWgtMatrix(InputRecID+1,TempArray(m)) =...
%                             ConnData(4);
%                         InputConnDelMatrix(InputRecID+1,TempArray(m)) =...
%                             5 + (10-5).*rand();
%                     end
%                 end
%                 InputRecID = InputRecID + 1;
%             end
%         end
%         RandPickArray(i,j) = {TempCell};
%     end
%     
% end
% 
% FileID = fopen(InputConnSynFile,'w');
% for i = 1:size(InputConnSynMatrix,1)
% 	for j = 1:size(InputConnSynMatrix,2)
% 		fprintf(FileID,'\t%d',InputConnSynMatrix(i,j));
% 	end
% 	fprintf(FileID,'\n');
% end
% fclose(FileID);
% 
% FileID = fopen(InputConnThrFile,'w');  
% for i = 1:size(InputConnThrMatrix,1)                  
%         for j = 1:size(InputConnThrMatrix,2)
%                 fprintf(FileID,'\t%d',InputConnThrMatrix(i,j));
%         end
%         fprintf(FileID,'\n');           
% end
% fclose(FileID);
% 
% FileID = fopen(InputConnWgtFile,'w');  
% for i = 1:size(InputConnWgtMatrix,1)                  
%         for j = 1:size(InputConnWgtMatrix,2)
%                 fprintf(FileID,'\t%d',InputConnWgtMatrix(i,j));
%         end
%         fprintf(FileID,'\n');           
% end
% fclose(FileID);
% 
% FileID = fopen(InputConnDelFile,'w');  
% for i = 1:size(InputConnDelMatrix,1)                  
%         for j = 1:size(InputConnDelMatrix,2)
%                 fprintf(FileID,'\t%d',InputConnDelMatrix(i,j));
%         end
%         fprintf(FileID,'\n');           
% end
% fclose(FileID);


end

