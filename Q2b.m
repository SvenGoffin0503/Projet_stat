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
%% 2(b) i. , 2(b) ii. , 2(b) iii.

Vect_ech = zeros(100,n,4);

for i = 1:100
    Vect_ech(i,:,:) = datasample(Data,n,1);
end

Vec_moy_ech_beer = zeros(100,1);
Vec_moy_ech_spir = zeros(100,1);
Vec_med_ech_beer = zeros(100,1);
Vec_med_ech_spir = zeros(100,1);
Vec_ET_ech_beer = zeros(100,1);
Vec_ET_ech_spir = zeros(100,1);

for i = 1:100
    Vec_moy_ech_beer(i) = mean(Vect_ech(i,:,1));
    Vec_moy_ech_spir(i) = mean(Vect_ech(i,:,2));
    
    Vec_med_ech_beer(i) = median(Vect_ech(i,:,1));
    Vec_med_ech_spir(i) = median(Vect_ech(i,:,2));
    
    Vec_ET_ech_beer(i) = std(Vect_ech(i,:,1));
    Vec_ET_ech_spir(i) = std(Vect_ech(i,:,2));
end

Vec_moy_ech_beer;
Vec_moy_ech_spir;
%--------------------------------------------------------------------------
%% figures

% Histogramme des moyennes des conso. de biere des echantillons
figure
histogram(Vec_moy_ech_beer,'FaceColor','b');
set(gca, 'fontsize', 20);
set(gcf,'color','w');

% Histogramme des moyennes des conso. d'alcool fort des echantillons
hold on
histogram(Vec_moy_ech_spir,'FaceColor','y');
set(gca, 'fontsize', 20);
set(gcf,'color','w');

xlabel('Moyennes (canettes-shots)');
ylabel('Frequences correspondantes');

% Histogramme des medianes des conso. de biere des echantillons
figure;
histogram(Vec_med_ech_beer,'FaceColor','b');
set(gca, 'fontsize', 20);
set(gcf,'color','w');

% Histogramme des medianes des conso. d'alcool fort des echantillons
hold on
histogram(Vec_med_ech_spir,'FaceColor','y');
set(gca, 'fontsize', 20);
set(gcf,'color','w');

xlabel('Medianes (canettes-shots)');
ylabel('Frequences correspondantes ');

% Histogramme des ET des conso. de biere des echantillons
figure;
histogram(Vec_ET_ech_beer,'FaceColor','b');
set(gca, 'fontsize', 20);
set(gcf,'color','w');

% Histogramme des ET des conso. d'alcool fort des echantillons
hold on
histogram(Vec_ET_ech_spir,'FaceColor','y');
set(gca, 'fontsize', 20);
set(gcf,'color','w');

xlabel('Ecart-types (canettes-shots)');
ylabel('Frequences correspondantes');

%--------------------------------------------------------------------------
%% Calcul des moyennes des differents vecteurs

Moy_vec_moy_beer = mean(Vec_moy_ech_beer);
Moy_vec_moy_spir = mean(Vec_moy_ech_spir);

Moy_vec_med_beer = mean(Vec_med_ech_beer);
Moy_vec_med_spir = mean(Vec_med_ech_spir);

Moy_vec_ET_beer = mean(Vec_ET_ech_beer);
Moy_vec_ET_spir = mean(Vec_ET_ech_spir);
%--------------------------------------------------------------------------
%% 2(b) iv. , 2(b) v.

% Calcul des frequences cumulees population
Freq_beer_pop = zeros(1, max(Data(:,1)) + 1);
Freq_spir_pop = zeros(1, max(Data(:,2)) + 1);
Freq_vin_pop = zeros(1, max(Data(:,3)) + 1);
Freq_pur_pop = zeros(1, 10 * max(Data(:,4)) + 1);

for i = 1:N
    Freq_beer_pop(1, Data(i,1) + 1) = Freq_beer_pop(1, Data(i,1) + 1) + 1;
    Freq_spir_pop(1, Data(i,2) + 1) = Freq_spir_pop(1, Data(i,2) + 1) + 1;
    Freq_vin_pop(1, Data(i, 3) + 1) = Freq_vin_pop(1, Data(i, 3) + 1) + 1;
    Freq_pur_pop(1, 10 * Data(i,4) + 1) = Freq_pur_pop(1, 10 * Data(i,4)...
        + 1) + 1;
end

Freq_beer_pop = Freq_beer_pop / N;
Freq_spir_pop = Freq_spir_pop / N;
Freq_vin_pop = Freq_vin_pop / N;
Freq_pur_pop = Freq_pur_pop / N;

Freq_cum_beer_pop = cumsum(Freq_beer_pop);
Freq_cum_spir_pop = cumsum(Freq_spir_pop);
Freq_cum_vin_pop = cumsum(Freq_vin_pop);
Freq_cum_pur_pop = cumsum(Freq_pur_pop);

% Calcul des frequences cumulees echantillons
Freq_ech_beer = zeros(100, max(Data(:,1)) + 1);
Freq_ech_spir = zeros(100, max(Data(:,2)) + 1);
Freq_ech_vin = zeros(100, max(Data(:,3)) + 1);
Freq_ech_pur = zeros(100, 10 * max(Data(:,4)) + 1);

for i = 1:100
    for j = 1:n
        Freq_ech_beer(i, Vect_ech(i, j, 1) + 1) = ...
                        Freq_ech_beer(i, Vect_ech(i, j, 1) + 1) + 1;
        Freq_ech_spir(i, Vect_ech(i, j, 2) + 1) = ...
                        Freq_ech_spir(i, Vect_ech(i, j, 2) + 1) + 1;
        Freq_ech_vin(i, Vect_ech(i, j, 3) + 1) = ...
                        Freq_ech_vin(i, Vect_ech(i, j, 3) + 1) + 1;
        Freq_ech_pur(i, 10 * Vect_ech(i, j, 4) + 1) = ...
                        Freq_ech_pur(i, 10 * Vect_ech(i, j, 4) + 1) + 1;
    end
end

Freq_ech_beer = Freq_ech_beer / n;
Freq_ech_spir = Freq_ech_spir / n;
Freq_ech_vin = Freq_ech_vin / n;
Freq_ech_pur = Freq_ech_pur / n;

Freq_ech_cum_beer = cumsum(Freq_ech_beer, 2);
Freq_ech_cum_spir = cumsum(Freq_ech_spir, 2);
Freq_ech_cum_vin = cumsum(Freq_ech_vin, 2);
Freq_ech_cum_pur = cumsum(Freq_ech_pur, 2);

% Calcul des distances de Kolmogorov Smirnov
ks_beer = zeros(100, 1);
ks_spir = zeros(100, 1);
ks_vin = zeros(100, 1);
ks_pur = zeros(100, 1);

for i = 1:100
    [~,~,ks_beer(i,1)] = kstest2(Freq_cum_beer_pop, Freq_ech_cum_beer(i,:));
    [~,~,ks_spir(i,1)] = kstest2(Freq_cum_spir_pop, Freq_ech_cum_spir(i,:));
    [~,~,ks_vin(i,1)] = kstest2(Freq_cum_vin_pop, Freq_ech_cum_vin(i,:));
    [~,~,ks_pur(i,1)] = kstest2(Freq_cum_pur_pop, Freq_ech_cum_pur(i,:));
end
%--------------------------------------------------------------------------
%% Figures

% Histogrammes des distances de Kolmogorov Smirnov
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
histogram(ks_vin);
set(gca, 'fontsize', 20);
set(gcf,'color','w');
xlabel('Distance de kolmogorov');
ylabel('Frequences correspondantes');

figure
histogram(ks_pur);
set(gca, 'fontsize', 20);
set(gcf,'color','w');
xlabel('Distance de kolmogorov');
ylabel('Frequences correspondantes');
%--------------------------------------------------------------------------
