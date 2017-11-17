
function Main_ModelGen()


s = RandStream('mcg16807','Seed',97652);
RandStream.setGlobalStream(s)

ModelXLSFileName = '../model.xls';

InputDataDir = '../Data_Input/';
OutputDataDir = '../Data_Output/';
NEURONScriptsDir = '../Scripts_NEURON/';

M3DFileName = 'CE.mat';

TypeSheetName = 'Types';
GroupSheetName = 'Groups';
InputSheetName = 'Inputs';
SynSheetName = 'Synapses';
InputConnSheetName = 'InputConns';
InternalConnSheetName = 'InternalConns';

TypeFileName = 'Data_Types.txt';
TypeFile = [InputDataDir,TypeFileName];
GroupFileName = 'Data_Groups.txt';
GroupFile = [InputDataDir,GroupFileName];
CellFileName = 'Data_Cells.txt';
CellFile = [InputDataDir,CellFileName];
InputFileName = 'Data_Inputs.txt';
InputFile = [InputDataDir,InputFileName];
SynFileName = 'Data_Synapses.txt';
SynFile = [InputDataDir,SynFileName];

InputConnSynFileName = 'Data_InputSynConns.txt';
InputConnSynFile = [InputDataDir,InputConnSynFileName];
InputConnThrFileName = 'Data_InputThrConns.txt';
InputConnThrFile = [InputDataDir,InputConnThrFileName];
InputConnDelFileName = 'Data_InputDelConns.txt';
InputConnDelFile = [InputDataDir,InputConnDelFileName];
InputConnWgtFileName = 'Data_InputWgtConns.txt';
InputConnWgtFile = [InputDataDir,InputConnWgtFileName];

InternalConnSynFileName = 'Data_InternalSynConns.txt';
InternalConnSynFile = [InputDataDir,InternalConnSynFileName];
InternalConnThrFileName = 'Data_InternalThrConns.txt';
InternalConnThrFile = [InputDataDir,InternalConnThrFileName];
InternalConnDelFileName = 'Data_InternalDelConns.txt';
InternalConnDelFile = [InputDataDir,InternalConnDelFileName];
InternalConnWgtFileName = 'Data_InternalWgtConns.txt';
InternalConnWgtFile = [InputDataDir,InternalConnWgtFileName];

CreateEachTypeFileName = 'function_CreateEachType.hoc';
CreateEachTypeFile = [NEURONScriptsDir,CreateEachTypeFileName];
MakeInputsFileName = 'function_MakeInputs.hoc';
MakeInputsFile = [NEURONScriptsDir,MakeInputsFileName];
CreateSynapsesFileName = 'function_CreateSynapses.hoc';
CreateSynapsesFile = [NEURONScriptsDir,CreateSynapsesFileName];
CreateConnectTwoCellsFileName = 'function_ConnectTwoCells.hoc';
CreateConnectTwoCellsFile = [NEURONScriptsDir,CreateConnectTwoCellsFileName];

SpacePlotFileName = 'SpacePlot';
SpacePlotFileFormat = 'jpg';
SpacePlotFile = [OutputDataDir,SpacePlotFileName,'.',SpacePlotFileFormat];

M3DFile = [InputDataDir,M3DFileName];
load(M3DFile);

TypeStruct = Func_Types(ModelXLSFileName,TypeSheetName,TypeFile);

GroupStruct = Func_Groups(ModelXLSFileName,GroupSheetName,GroupFile);

CellStruct = Func_Cells(TypeStruct,GroupStruct,pos,CellFile);

InputStruct = Func_Inputs(ModelXLSFileName,InputSheetName,InputFile);

[InputConnSynMatrix,InputConnThrMatrix,InputConnWgtMatrix,...
    InputConnDelMatrix] = Func_InputConns(ModelXLSFileName,...
    InputConnSheetName,CellStruct,InputStruct,InputConnSynFile,...
    InputConnThrFile,InputConnDelFile,InputConnWgtFile);

[InternalConnSynMatrix,InternalConnThrMatrix,InternalConnWgtMatrix,...
    InternalConnDelMatrix] = Func_InternalConns(ModelXLSFileName,...
    InternalConnSheetName,CellStruct,InternalConnSynFile,...
    InternalConnThrFile,InternalConnDelFile,InternalConnWgtFile);
%%
SynStruct = Func_Synapses(ModelXLSFileName,SynSheetName,SynFile);

Func_CreateEachType(TypeStruct,CreateEachTypeFile);

Function_MakeInputs(InputStruct,MakeInputsFile,InputDataDir);

Func_CreateSynapses(SynStruct,CreateSynapsesFile);

Func_CreateConnectTwoCells(SynStruct,CreateConnectTwoCellsFile);

%SpacePlot(1,CellStruct,TypeStruct,SpacePlotFile,SpacePlotFileFormat,t,p,'BLA 3D Model');

save('Model.mat','CellStruct','GroupStruct','InputConnDelMatrix',...
    'InputConnSynMatrix','InputConnThrMatrix','InputConnWgtMatrix',...
    'InputStruct','SynStruct','TypeStruct');

	end