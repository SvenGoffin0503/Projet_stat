%==========================================================================
% Question 1 : Analyse descriptive
%   
%   GOFFIN Sven
%   CRUTZEN Gilles
%==========================================================================
%% Chargement des donnees

Data = csvread('db_stat75.csv',1,1);
Data_bel = Data(1, :);
Size = size(Data);
N = size(Data(:,1));
N = N(1);

if(Size(1) ~= 100 || Size(2) ~= 4)
    disp('ERREUR : LECTURE DU FICHIER ERRONEE');
end
%--------------------------------------------------------------------------
%% (a) Histogramme de la consommation de biere et de spiritueux

Data_red = zeros(100,2);
Data_red(:,1) = Data(:,1);
Data_red(:,2) = Data(:,2);

figure
histogram(Data_red(:,1),'FaceColor','b')
hold on
histogram(Data_red(:,2),'FaceColor','y')

xlabel('Quantites consommees (canettes-shots)');
ylabel('Frequences correspondantes');
set(gca, 'fontsize', 20);
set(gcf,'color','w')
hold off
%--------------------------------------------------------------------------
%% (b) Moyenne, mediane, mode et ecart-type (biere et spiritueux)

Moy_beer = mean(Data(:,1));
Moy_spir = mean(Data(:,2));

Med_beer = median(Data(:,1));
Med_spir = median(Data(:,2));

Mod_beer = mode(Data(:,1));
Mod_spir = mode(Data(:,2));

ET_beer = std(Data(:,1));
ET_spir = std(Data(:,2));
%--------------------------------------------------------------------------
%% (c) Consommation normale

Inf_bound_beer = Moy_beer - ET_beer;
Sup_bound_beer = Moy_beer + ET_beer;
Inf_bound_spirit = Moy_spir - ET_spir;
Sup_bound_spirit = Moy_spir + ET_spir;

Cnt_anormal_beer = 0;
Cnt_anormal_spir = 0;

for i = 1:N
    if(Data(i, 1) < Inf_bound_beer || Data(i, 1) > Sup_bound_beer)
        Cnt_anormal_beer = Cnt_anormal_beer + 1;
    end
    
    if(Data(i, 2) < Inf_bound_spirit || Data(i, 2) > Sup_bound_spirit)
        Cnt_anormal_spir = Cnt_anormal_spir + 1;
    end
end

Prop_anormal_beer = Cnt_anormal_beer / N;
Prop_anormal_spir = Cnt_anormal_spir / N;
%--------------------------------------------------------------------------
%% (d) Boites a moustaches (consommation de biere et de spiritueux)

figure
boxplot(Data_red(:,1));
xlabel('Biere');
ylabel('Quantites consommees (canettes)');
set(gca, 'fontsize', 20);
set(gcf,'color','w');

figure
boxplot(Data_red(:,2));
xlabel('Alcool fort');
ylabel('Quantites consommees (shots)');
set(gca, 'fontsize', 20);
set(gcf,'color','w');

Q1_beer = quantile(Data(:,1),0.25);
Q3_beer = quantile(Data(:,1),0.75);

Q1_spir = quantile(Data(:,2),0.25);
Q3_spir = quantile(Data(:,2),0.75);

Moust_sup_spir = Q3_spir + 1.5 * (Q3_spir - Q1_spir);

for i = 1:N
    if(Data(i, 2) > Moust_sup_spir)
        Data(i, 2);
    end
end
%--------------------------------------------------------------------------
%% (e) Polygones des frequences cumulees de la consommation de biere

Cons_beer = 0:max(Data(:,1));
Freq_beer = zeros(1, max(Data(:,1)) + 1);

Inf_bound = 200;
Cons_beer_bel = Data_bel(1);
Prop_countries = 0;

for i = 1:N
    Freq_beer(1, Data(i, 1) + 1) = Freq_beer(1, Data(i, 1) + 1) + 1;
    
    if(Data(i,1) > Inf_bound && Data(i,1) < Cons_beer_bel)
        Prop_countries = Prop_countries + 1;
    end
end

Freq_beer = Freq_beer / N;
Freq_cum_beer = cumsum(Freq_beer);

figure;
plot(Cons_beer, Freq_cum_beer);
xlabel('Consommation de biere (canettes)');
ylabel('Frequences cumulees');
set(gca, 'fontsize', 20);
set(gcf,'color','w');

Prop_countries = Prop_countries / N;
%--------------------------------------------------------------------------
%% (f) Scatterplots et coefficient de correlation

Cons_pure = Data(: ,4);
Cons_beer = Data(:, 1);
Cons_spir = Data(:, 2);
Cons_wine = Data(:, 3);

Moy_pure = mean(Data(:,4));
Moy_wine = mean(Data(:,3));
ET_pure = std(Data(:,4));
ET_wine = std(Data(:,3));

figure;
scatter(Cons_pure, Cons_beer);
%title('Comparaison entre la consommation d''alcool pur et la consommation de biere');
xlabel('consommation d''alcool pur (litres)');
ylabel('consommation de biere (canettes)');
set(gca, 'fontsize', 20);
set(gcf,'color','w');
figure;
scatter(Cons_pure, Cons_spir);
%title('Comparaison entre la consommation d''alcool pur et la consommation de spiritueux');
xlabel('consommation d''alcool pur (litres)');
ylabel('consommation de spiritueux (shots)');
set(gca, 'fontsize', 20);
set(gcf,'color','w');
figure;
scatter(Cons_pure, Cons_wine);
%title('Comparaison entre la consommation d''alcool pur et la consommation de vin');
xlabel('consommation d''alcool pur (litres)');
ylabel('consommation de vin (verres)');
set(gca, 'fontsize', 20);
set(gcf,'color','w');


Coef_cor_pure_beer = 0;
Coef_cor_pure_spir = 0;
Coef_cor_pure_wine = 0;

for i = 1:N
    Coef_cor_pure_beer = Coef_cor_pure_beer + (Cons_pure(i) - Moy_pure) * (Cons_beer(i) - Moy_beer);
    Coef_cor_pure_spir = Coef_cor_pure_spir + (Cons_pure(i) - Moy_pure) * (Cons_spir(i) - Moy_spir);
    Coef_cor_pure_wine = Coef_cor_pure_wine + (Cons_pure(i) - Moy_pure) * (Cons_wine(i) - Moy_wine);
end

Coef_cor_pure_beer = Coef_cor_pure_beer / (N * ET_beer * ET_pure);
Coef_cor_pure_spir = Coef_cor_pure_spir / (N * ET_spir * ET_pure);
Coef_cor_pure_wine = Coef_cor_pure_wine / (N * ET_wine * ET_pure);
%--------------------------------------------------------------------------
