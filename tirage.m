%==========================================================================
% Cette fonction tire un échantillon i.i.d. de taille n dans la population
% Data.
%
% ARGUMENTS:
%       -> n : taille de l'échantillon
%       -> Data : données de la population
% RETURN:
%       -> E : données de l'échantillon
%==========================================================================
function [ E ] = tirage(n, Data)

    E = zeros(n, 4);
    Rand_vec = randi([1,100], n, 1 );
    for i=1:n
        E(i,:) = Data(Rand_vec(i),:);
    end
end

