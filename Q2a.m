%==========================================================================
% Question 2 : Generation d'echantillons i.i.d.
%   
%   CRUTZEN Gilles
%   GOFFIN Sven
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
%--------------------------------------------------------------------------
%% 2(a) Tirage de l'echantillon

Ech = datasample(Data, n, 1);
%--------------------------------------------------------------------------
%% 2(a)i. Moyenne, mediane et ecart-type echantillon (biere et spiritueux)

Moy_Ech_beer = mean(Ech(:,1));
Moy_Ech_spir = mean(Ech(:,2));

Med_Ech_beer = median(Ech(:,1));
Med_Ech_spir = median(Ech(:,2));

ET_Ech_beer = std(Ech(:,1));
ET_Ech_spir = std(Ech(:,2));
%--------------------------------------------------------------------------
%% 2(a)ii. Boites a moustaches (consommations de biere et de spiritueux)

E_red = zeros(n,2);
E_red(:,1) = Ech(:,1);
E_red(:,2) = Ech(:,2);

boxplot(E_red);
%--------------------------------------------------------------------------
%% 2(a)iii. Polygones des frequences cumulees (biere et spiritueux)

Cons_ech_beer = 0:max(Data(:,1));
Cons_ech_spir = 0:max(Data(:,2));

Freq_ech_beer = zeros(1, max(Data(:,1)) + 1);
Freq_ech_spir = zeros(1, max(Data(:,2)) + 1);

for i = 1:n
    Freq_ech_beer(1, Ech(i, 1) + 1) = Freq_ech_beer(1, Ech(i, 1) + 1) + 1;
    Freq_ech_spir(1, Ech(i, 2) + 1) = Freq_ech_spir(1, Ech(i, 2) + 1) + 1;
end

Freq_ech_beer = Freq_ech_beer / n;
Freq_ech_spir = Freq_ech_spir / n;
Freq_E_cum_beer = cumsum(Freq_ech_beer);
Freq_E_cum_spir = cumsum(Freq_ech_spir);

figure;
plot(Cons_ech_beer, Freq_E_cum_beer);
title('Polygone des frequences cumulees de la consommation de biere');
figure;
plot(Cons_ech_spir, Freq_E_cum_spir);
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
Freq_cum_beer = cumsum(Freq_beer);
Freq_cum_spir = cumsum(Freq_spir);

[~,~,ks_beer] = kstest2(Freq_cum_beer, Freq_E_cum_beer);
[~,~,ks_spir] = kstest2(Freq_cum_spir, Freq_E_cum_spir);
%--------------------------------------------------------------------------
