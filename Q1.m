%==========================================================================
% Question 1 : Analyse descriptive
%   
%   CRUTZEN Gilles
%   GOFFIN Sven
%==========================================================================
%% Chargement des donnees

Data = csvread('db_stat75.csv',1,1);
Data_Bel = Data(1, :);
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

ET_beer = std(Data(:,1),1);
ET_spir = std(Data(:,2),1);
%--------------------------------------------------------------------------
%% (c) Consommation normale au sens de la loi normale

Borne_inf_beer = Moy_beer - ET_beer;
Borne_sup_beer = Moy_beer + ET_beer;
Borne_inf_spir = Moy_spir - ET_spir;
Borne_sup_spir = Moy_spir + ET_spir;

Cnt_anormal_beer = 0;
Cnt_anormal_spir = 0;

for i = 1:N
    if(Data(i, 1) < Borne_inf_beer || Data(i, 1) > Borne_sup_beer)
        Cnt_anormal_beer = Cnt_anormal_beer + 1;
    end
    
    if(Data(i, 2) < Borne_inf_spir || Data(i, 2) > Borne_sup_spir)
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

Borne_inf = 200;
Cons_beer_Bel = Data_Bel(1);
Prop_pays = 0;

for i = 1:N
    Freq_beer(1, Data(i, 1) + 1) = Freq_beer(1, Data(i, 1) + 1) + 1;
    
    if(Data(i,1) > Borne_inf && Data(i,1) < Cons_beer_Bel)
        Prop_pays = Prop_pays + 1;
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

Prop_pays = Prop_pays / N;
%--------------------------------------------------------------------------
%% (f) Scatterplots et coefficients de correlation

Cons_pur = Data(: ,4);
Cons_beer = Data(:, 1);
Cons_spir = Data(:, 2);
Cons_vin = Data(:, 3);

Moy_pur = mean(Data(:,4));
Moy_vin = mean(Data(:,3));
ET_pur = std(Data(:,4),1);
ET_vin = std(Data(:,3),1);

% Comparaison entre les consommations d'alcool pur et de biere
figure;
scatter(Cons_pur, Cons_beer);
xlabel('consommation d''alcool pur (litres)');
ylabel('consommation de biere (canettes)');
set(gca, 'fontsize', 20);
set(gcf,'color','w');

% Comparaison entre les consommations d'alcool pur et de spiritueux
figure;
scatter(Cons_pur, Cons_spir);
xlabel('consommation d''alcool pur (litres)');
ylabel('consommation de spiritueux (shots)');
set(gca, 'fontsize', 20);
set(gcf,'color','w');

% Comparaison entre les consommations d'alcool pur et de vin
figure;
scatter(Cons_pur, Cons_vin);
xlabel('consommation d''alcool pur (litres)');
ylabel('consommation de vin (verres)');
set(gca, 'fontsize', 20);
set(gcf,'color','w');

% Calcul des coefficients de correlation
Coef_cor_pur_beer = corrcoef(Cons_pur, Cons_beer);
Coef_cor_pur_spir = corrcoef(Cons_pur, Cons_spir);
Coef_cor_pur_vin = corrcoef(Cons_pur, Cons_vin);
%--------------------------------------------------------------------------
