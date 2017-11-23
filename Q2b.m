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
    vect_E(i,:,:) = datasample(Data,n,1);
end

Vec_moy_E_beer = zeros(100,1);
Vec_moy_E_spir = zeros(100,1);
Vec_med_E_beer = zeros(100,1);
Vec_med_E_spir = zeros(100,1);
Vec_ET_E_beer = zeros(100,1);
Vec_ET_E_spir = zeros(100,1);

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

%--------------------------------------------------------------------------
%% figures

figure
histogram(Vec_moy_E_beer,'FaceColor','b');
%title('histograme des moy des conso des bieres');
set(gca, 'fontsize', 20);
set(gcf,'color','w');
hold on
histogram(Vec_moy_E_spir,'FaceColor','y');
%title('histograme des moy des conso des fort');
set(gca, 'fontsize', 20);
set(gcf,'color','w');

xlabel('Moyennes (canettes-shots)');
ylabel('Frequences correspondantes');

Moy_vec_moy_bier=mean(Vec_moy_E_beer);
Moy_vec_moy_fort=mean(Vec_moy_E_spir);

figure
histogram(Vec_med_E_beer,'FaceColor','b');
%title('histograme des med des conso des bieres');
set(gca, 'fontsize', 20);
set(gcf,'color','w');
hold on
histogram(Vec_med_E_spir,'FaceColor','y');
%title('histograme des med des conso des fort');
set(gca, 'fontsize', 20);
set(gcf,'color','w');
xlabel('Medianes (canettes-shots)');
ylabel('Frequences correspondantes ');

Moy_vec_med_bier=mean(Vec_med_E_beer);
Moy_vec_med_fort=mean(Vec_med_E_spir);

figure
histogram(Vec_ET_E_beer,'FaceColor','b');
%title('histograme des ET des conso des bieres');
set(gca, 'fontsize', 20);
set(gcf,'color','w');
hold on
histogram(Vec_ET_E_spir,'FaceColor','y');
%title('histograme des ET des conso des fort');
set(gca, 'fontsize', 20);
set(gcf,'color','w');
xlabel('Ecart-types (canettes-shots)');
ylabel('Frequences correspondantes');

Moy_vec_ET_bier=mean(Vec_ET_E_beer);
Moy_vec_ET_fort=mean(Vec_ET_E_spir);

%% Calcul des distances de Kolmogorov Smirnov

% Calcul des frequences cumulees population

Freq_beer_popu = zeros(1, max(Data(:,1)) + 1);
Freq_spir_popu = zeros(1, max(Data(:,2)) + 1);
Freq_wine_popu = zeros(1, max(Data(:,3)) + 1);
Freq_pure_popu = zeros(1, 10 * max(Data(:,4)) + 1);

for i = 1:N
    Freq_beer_popu(1, Data(i, 1) + 1) = Freq_beer_popu(1, Data(i, 1) + 1) + 1;
    Freq_spir_popu(1, Data(i, 2) + 1) = Freq_spir_popu(1, Data(i, 2) + 1) + 1;
    Freq_wine_popu(1, Data(i, 3) + 1) = Freq_wine_popu(1, Data(i, 3) + 1) + 1;
    Freq_pure_popu(1, 10 * Data(i, 4) + 1) = Freq_pure_popu(1, 10 * Data(i, 4) + 1) + 1;
end

Freq_beer_popu = Freq_beer_popu / N;
Freq_spir_popu = Freq_spir_popu / N;
Freq_wine_popu = Freq_wine_popu / N;
Freq_pure_popu = Freq_pure_popu / N;

Freq_cum_beer_popu = cumsum(Freq_beer_popu);
Freq_cum_spir_popu = cumsum(Freq_spir_popu);
Freq_cum_wine_popu = cumsum(Freq_wine_popu);
Freq_cum_pure_popu = cumsum(Freq_pure_popu);

% Calcul des frequences cumulees echantillons

Freq_E_beer = zeros(100, max(Data(:,1)) + 1);
Freq_E_spir = zeros(100, max(Data(:,2)) + 1);
Freq_E_wine = zeros(100, max(Data(:,3)) + 1);
Freq_E_pure = zeros(100, 10 * max(Data(:,4)) + 1);

for i = 1:100
    for j = 1:n
        Freq_E_beer(i, vect_E(i, j, 1) + 1) = Freq_E_beer(i, vect_E(i, j, 1) + 1) + 1;
        Freq_E_spir(i, vect_E(i, j, 2) + 1) = Freq_E_spir(i, vect_E(i, j, 2) + 1) + 1;
        Freq_E_wine(i, vect_E(i, j, 3) + 1) = Freq_E_wine(i, vect_E(i, j, 3) + 1) + 1;
        Freq_E_pure(i, 10 * vect_E(i, j, 4) + 1) = Freq_E_pure(i, 10 * vect_E(i, j, 4) + 1) + 1;
    end
end

Freq_E_beer = Freq_E_beer / n;
Freq_E_spir = Freq_E_spir / n;
Freq_E_wine = Freq_E_wine / n;
Freq_E_pure = Freq_E_pure / n;

Freq_E_cum_beer = cumsum(Freq_E_beer, 2);
Freq_E_cum_spir = cumsum(Freq_E_spir, 2);
Freq_E_cum_wine = cumsum(Freq_E_wine, 2);
Freq_E_cum_pure = cumsum(Freq_E_pure, 2);



ks_beer = zeros(100, 1);
ks_spir = zeros(100, 1);
ks_wine = zeros(100, 1);
ks_pure = zeros(100, 1);

for i = 1:100
    [~,~,ks_beer(i,1)] = kstest2(Freq_cum_beer_popu, Freq_E_cum_beer(i,:));
    [~,~,ks_spir(i,1)] = kstest2(Freq_cum_spir_popu, Freq_E_cum_spir(i,:));
    [~,~,ks_wine(i,1)] = kstest2(Freq_cum_wine_popu, Freq_E_cum_wine(i,:));
    [~,~,ks_pure(i,1)] = kstest2(Freq_cum_pure_popu, Freq_E_cum_pure(i,:));
end
%--------------------------------------------------------------------------


figure
histogram(ks_beer);
set(gca, 'fontsize', 20);
set(gcf,'color','w');
xlabel('Distance de kolmogorov');
ylabel('Frequences correspondantes');

figure
histogram(ks_spir);
set(gca, 'fontsize', 20);
set(gcf,'color','w');
xlabel('Distance de kolmogorov');
ylabel('Frequences correspondantes');

figure
histogram(ks_wine);
set(gca, 'fontsize', 20);
set(gcf,'color','w');
xlabel('Distance de kolmogorov');
ylabel('Frequences correspondantes');

figure
histogram(ks_pure);
set(gca, 'fontsize', 20);
set(gcf,'color','w');
xlabel('Distance de kolmogorov');
ylabel('Frequences correspondantes');
%--------------------------------------------------------------------------
