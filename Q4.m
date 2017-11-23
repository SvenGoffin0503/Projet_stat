%==========================================================================
% Question 4 : Tests d'hypotheses
%   
%   GOFFIN Sven
%   CRUTZEN Gilles
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

Prop_popu = 0;

for i = 1:N
    if(Data(i,1) > Cons_beer_Bel)
        Prop_popu = Prop_popu + 1;
    end
end

Prop_popu = Prop_popu / N;
%--------------------------------------------------------------------------
%% Regle de decision : calcul de la proportion max. a ne pas depasser

% Deduit d'un raisonnement theorique faisant l'hypothese que la proportion
% de pays ayant une consommation de biere superieure a celle de la Belgique
% suit une loi normale de moyenne Prop_popu et d'ecart-type 
% sqrt(Prop_popu * (1 - Prop_popu) / n)

Upper_bound = 1.64486 * sqrt(Prop_popu * (1 - Prop_popu) / n) + Prop_popu;
%--------------------------------------------------------------------------
%% Tests de l'hypothese

Rej_bel_state = 0;
Rej_tot = 0;

for i = 1:100
    Already_rej = 0;
    
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
        
        % Test de l'hypothese pour l'etat belge
        if(Prop_ech > Upper_bound)
            % Test de l'hypothese pour l'etat belge
            if(j==1)
                Rej_bel_state = Rej_bel_state + 1;

            % Test de l'hypothese pour les instituts
            else
                Already_rej = 1;
            end
        end
    end
    % L'hypothese nulle a-t-elle ete rejetee par l'etat belge ou l'un des
    % instituts de statistique?
    if(Already_rej == 1)
        Rej_tot = Rej_tot + 1;
    end
end

Prop_rej_bel_state = Rej_bel_state / 100;
Prop_rej_tot = Rej_tot / 100;
