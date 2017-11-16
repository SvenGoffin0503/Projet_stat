%==========================================================================
% Cette fonction tire un echantillon i.i.d. de taille n dans la population
% Data.
%
% ARGUMENTS:
%       -> n : taille de l'echantillon
%       -> Data : donnees de la population
%       -> is_Q4 : valeur booléenne indiquant si l'appel courant est 
%                  effectué à la question 4 (1) ou non (0)
% RETURN:
%       -> E : donnees de l'echantillon
%==========================================================================
function [ E ] = tirage(n, Data, is_Q4)

    switch is_Q4
        case 0
            E = zeros(n, 4);
            Rand_vec = randi([1,100], n, 1 );
            for i=1:n
                E(i,:) = Data(Rand_vec(i),:);
            end
            
        case 1
            E = zeros(n, 4);
            % La Belgique fait obligatoirement partie de l'echantillon
            E(1,:) = Data(1,:);
            Rand_vec = randi([1,100], n, 1 );
            for i=2:n
                E(i,:) = Data(Rand_vec(i),:);
            end
    end
end

