function OutputArray = Func_RandArrayGen( InputArray,P )
%FUNC_RANDARRAYGEN Summary of this function goes here
%   Detailed explanation goes here

FullLength = length(InputArray);
OutputLength = round(P*FullLength);
randind = randperm(FullLength);
pickind = randind(1:OutputLength);
OutputArray = InputArray(pickind);
end