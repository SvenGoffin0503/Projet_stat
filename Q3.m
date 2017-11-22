%==========================================================================
% Question 3 : Estimation
%   
%   GOFFIN Sven
%   CRUTZEN Gilles
%==========================================================================
%% Chargement des donnees

Data = csvread('db_stat75.csv',1,1);
Size = size(Data);
N = size(Data(:,1));
N = N(1);
n = 20;

if(Size(1) ~= 100 || Size(2) ~= 4)
    disp('ERREUR : LECTURE DU FICHIER ERRONEE');
end

Moy_pop = mean(Data(:,3));
%--------------------------------------------------------------------------
%% Tirage des echantillons

Vec_ech_20 = zeros(100,n);

for i = 1:100
    Ech = tirage(n,Data,0);
    Vec_ech_20(i,:) = Ech(:,3);
end
%--------------------------------------------------------------------------
%% 3(a)

Vec_moy_20 = mean(Vec_ech_20, 2);
Biais_moy_20 = abs(mean(Vec_moy_20) - Moy_pop);
Var_esti_moy_20 = var(Vec_moy_20);
%--------------------------------------------------------------------------
%% 3(b)

Vec_med_20 = median(Vec_ech_20, 2);
Biais_med_20 = abs(mean(Vec_med_20) - Moy_pop);
Var_esti_med_20 = var(Vec_med_20);
%--------------------------------------------------------------------------
%% Nouvelle taille d'echantillon
n = 50;
%--------------------------------------------------------------------------
%% Tirage des nouveaux echantillons

Vec_ech_50 = zeros(100,n);

for i = 1:100
    Ech = tirage(n,Data,0);
    Vec_ech_50(i,:) = Ech(:,3);
end
%--------------------------------------------------------------------------
%% 3(c)

Vec_moy_50 = mean(Vec_ech_50, 2);
Biais_moy_50 = abs(mean(Vec_moy_50) - Moy_pop);
Var_esti_moy_50 = var(Vec_moy_50);


Vec_med_50 = median(Vec_ech_50, 2);
Biais_med_50 = abs(mean(Vec_med_50) - Moy_pop);
Var_esti_med_50 = var(Vec_med_50);
%--------------------------------------------------------------------------
%% 3(d) donnees utiles
n = 20;
t = 2.093;
u = 1.96;
S_19 = std(Vec_ech_20, 0, 2);
%--------------------------------------------------------------------------
%% 3(d) i.
Inter_tstu = zeros(100, 2);
Inter_tstu(:,1) = Vec_moy_20 - t*S_19/sqrt(n);
Inter_tstu(:,2) = Vec_moy_20 + t*S_19/sqrt(n);
%--------------------------------------------------------------------------
%% 3(d) ii.
Inter_Gauss = zeros(100, 2);
Inter_Gauss(:,1) = Vec_moy_20 - u*S_19/sqrt(n);
Inter_Gauss(:,2) = Vec_moy_20 + u*S_19/sqrt(n);
%--------------------------------------------------------------------------
%% 
cnt_tstu = 0;
cnt_Gauss = 0;
for i = 1:100
    if(Moy_pop >= Inter_tstu(i,1) && Moy_pop <= Inter_tstu(i,2))
        cnt_tstu = cnt_tstu + 1;
    end
    if(Moy_pop >= Inter_Gauss(i,1) && Moy_pop <= Inter_Gauss(i,2))
        cnt_Gauss = cnt_Gauss + 1;
    end
end
