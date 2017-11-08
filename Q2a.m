%==========================================================================
% Question 2 : Generation d'echantillon i.i.d.
%   
%   GOFFIN Sven
%   CRUTZEN Gilles
%==========================================================================
%% Chargement des données

Data = csvread('db_stat75.csv',1,1);
Size = size(Data);
N = size(Data(:,1));
N = N(1);
n = 20;

if(Size(1) ~= 100 || Size(2) ~= 4)
    disp('ERREUR : LECTURE DU FICHIER ERRONEE');
end
%--------------------------------------------------------------------------
%% (a) Tirage de l'echantillon

E = tirage(n, Data);
%--------------------------------------------------------------------------
%% (a)i. Moyenne, mediane et ecart-type de l'echantillon (biere et spiritueux)

Moy_E_beer = mean(E(:,1));
Moy_E_spir = mean(E(:,2));

Med_E_beer = median(E(:,1));
Med_E_spir = median(E(:,2));

ET_E_beer = std(E(:,1));
ET_E_spir = std(E(:,2));
%--------------------------------------------------------------------------
%% (a)ii. Boites a moustaches (consommation de biere et de spiritueux)

E_red = zeros(n,2);
E_red(:,1) = E(:,1);
E_red(:,2) = E(:,2);

boxplot(E_red);
%--------------------------------------------------------------------------
%% (a)iii. Polygones des frequences cumulees de la consommation de biere et de spiritueux

Cons_E_beer = 0:max(Data(:,1));
Cons_E_spir = 0:max(Data(:,2));

Freq_E_beer = zeros(1, max(Data(:,1)) + 1);
Freq_E_spir = zeros(1, max(Data(:,2)) + 1);

for i = 1:n
    Freq_E_beer(1, E(i, 1) + 1) = Freq_E_beer(1, E(i, 1) + 1) + 1;
    Freq_E_spir(1, E(i, 2) + 1) = Freq_E_spir(1, E(i, 2) + 1) + 1;
end

Freq_E_beer = Freq_E_beer / n;
Freq_E_spir = Freq_E_spir / n;
Freq_E_cum_beer = cumsum(Freq_E_beer);
Freq_E_cum_spir = cumsum(Freq_E_spir);

figure;
plot(Cons_E_beer, Freq_E_cum_beer);
title('Polygone des frequences cumulees de la consommation de biere');
figure;
plot(Cons_E_spir, Freq_E_cum_spir);
title('Polygone des frequences cumulees de la consommation de spiritueux');

% Calcul des distances de Kolmogorov Smirnov

Freq_beer = zeros(1, max(Data(:,1)) + 1);
Freq_spir = zeros(1, max(Data(:,2)) + 1);

for i = 1:N
    Freq_beer(1, Data(i, 1) + 1) = Freq_beer(1, Data(i, 1) + 1) + 1;
    Freq_spir(1, Data(i, 2) + 1) = Freq_spir(1, Data(i, 2) + 1) + 1;
end

Freq_beer = Freq_beer / N;
Freq_spir = Freq_spir / N;
Freq_cum_bier = cumsum(Freq_beer);
Freq_cum_fort = cumsum(Freq_spir);

Dist_beer = abs(Freq_cum_bier - Freq_E_cum_beer);
Dist_spir = abs(Freq_cum_fort - Freq_E_cum_spir);
Dist_KS_beer = max(Dist_beer);
Dist_KS_spir = max(Dist_spir);
%--------------------------------------------------------------------------
