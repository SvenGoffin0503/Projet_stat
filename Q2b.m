%==========================================================================
% Question 2 : Generation d'echantillon i.i.d.
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
%--------------------------------------------------------------------------
%% 2(b)i  Moyenne

vect_E = zeros(100,n,4);

for i = 1:100
    vect_E(i,:,:) = tirage(n,Data, 0);
end

Vec_moy_E_beer = zeros(100,1);
Vec_moy_E_spir = zeros(100,1);

for i = 1:100
    Vec_moy_E_beer(i) = mean(vect_E(i,:,1));
    Vec_moy_E_spir(i) = mean(vect_E(i,:,2));
    
    Vec_med_E_beer(i) = median(vect_E(i,:,1));
    Vec_med_E_spir(i) = median(vect_E(i,:,2));
    
    Vec_ET_E_beer(i) = std(vect_E(i,:,1));
    Vec_ET_E_spir(i) = std(vect_E(i,:,2));
end

Vec_moy_E_beer;
Vec_moy_E_spir;

figure
histogram(Vec_moy_E_beer);
title('histograme des moy des conso des bieres');
figure
histogram(Vec_moy_E_spir);
title('histograme des moy des conso des fort');
Moy_vec_moy_bier=mean(Vec_moy_E_beer);
Moy_vec_moy_fort=mean(Vec_moy_E_spir);

figure
histogram(Vec_med_E_beer);
title('histograme des med des conso des bieres');
figure
histogram(Vec_med_E_spir);
title('histograme des med des conso des fort');
Moy_vec_med_bier=mean(Vec_med_E_beer);
Moy_vec_med_fort=mean(Vec_med_E_spir);

figure
histogram(Vec_ET_E_beer);
title('histograme des ET des conso des bieres');
figure
histogram(Vec_ET_E_spir);
title('histograme des ET des conso des fort');
Moy_vec_ET_bier=mean(Vec_ET_E_beer);
Moy_vec_ET_fort=mean(Vec_ET_E_spir);
