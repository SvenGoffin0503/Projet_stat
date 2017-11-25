%==========================================================================
% Question 4 : Tests d'hypotheses
%   
%   CRUTZEN Gilles
%   GOFFIN Sven
%==========================================================================
%% Chargement des donnees

Data = csvread('db_stat75.csv',1,1);
Size = size(Data);
N = size(Data(:,1));
N = N(1);
n = 50;
Cons_beer_Bel = Data(1,1);

if(Size(1) ~= 100 || Size(2) ~= 4)
    disp('ERREUR : LECTURE DU FICHIER ERRONEE');
end
%--------------------------------------------------------------------------
%% Tirage des echantillons

% 100 * 6 tirages d'echantillons de 50 pays
Table_ech = zeros(100,6,n);

for i = 1:100
    for j=1:6   
        Tir = datasample(Data,n,1); 
        Table_ech(i,j,:)= Tir(:,1);           
    end
end
%--------------------------------------------------------------------------
%% Proportion de pays consommant plus de biere que la Belgique

Prop_pop = 0;

for i = 1:N
    if(Data(i,1) > Cons_beer_Bel)
        Prop_pop = Prop_pop + 1;
    end
end

Prop_pop = Prop_pop / N;
%--------------------------------------------------------------------------
%% Regle de decision : calcul de la proportion max. a ne pas depasser

% Deduit d'un raisonnement theorique faisant l'hypothese que la proportion
% de pays ayant une consommation de biere superieure a celle de la Belgique
% suit une loi normale de moyenne Prop_popu et d'ecart-type 
% sqrt(Prop_popu * (1 - Prop_popu) / n)

borne_sup = 1.64486 * sqrt(Prop_pop * (1 - Prop_pop) / n) + Prop_pop;
%--------------------------------------------------------------------------
%% 4(a), 4(b) Tests de l'hypothese

Rej_Bel = 0;
Rej_OMS = 0;

for i = 1:100
    Deja_rej = 0;
    
    for j = 1:6
        Prop_ech = 0;
        
        % Calcul de la proportion de pays ayant une consommation de biere
        % superieure a celle de la Belgique dans l'echantillon
        for k = 1:n
            if(Table_ech(i,j,k) > Cons_beer_Bel)
                Prop_ech = Prop_ech + 1;
            end
        end
        
        Prop_ech = Prop_ech / n;
        
        % Test de l'hypothese
        if(Prop_ech > borne_sup)
            % Rejet de l'hypothese par l'etat belge
            if(j==1)
                Rej_Bel = Rej_Bel + 1;

            % Rejet de l'hypothese par les instituts de statistique
            else
                Deja_rej = 1;
            end
        end
    end
    % L'hypothese nulle a-t-elle ete rejetee par l'un des instituts de 
    % statistique?
    if(Deja_rej == 1)
        Rej_OMS = Rej_OMS + 1;
    end
end

Prop_rej_Bel = Rej_Bel / 100;
Prop_rej_OMS = Rej_OMS / 100;
%--------------------------------------------------------------------------
