%% Question 1
%   
%  GOFFIN Sven
%  CRUTZEN Gilles
%%
M = csvread('db_stat75.csv',1,1);
siz = size(M);

if(siz(1)~= 100 && siz(2)~= 4)
    disp('ERREUR DANS LA LECTURE DU FICHIER');
end
%% (a) Histogramme
% Graphique representant la frequence (repartition) des differentes
% variables à l aide d un graphique
% Matrice reduite en gardant que les 2 premieres colonnes
M_red = zeros(100,2);
M_red(:,1)=M(:,1);
M_red(:,2)=M(:,2);

hist(M_red)

%% (b) Moyenne mediane mode et ecart type (biere et alcool fort)
%Mode = valeur la plus représentée dans la densite

Moy_bier = mean(M(:,1));
Moy_fort = mean(M(:,2));

Med_bier = median(M(:,1));
Med_fort = median(M(:,2));

Mod_bier = mode(M(:,1));
Mod_fort = mode(M(:,2));

ET_bier = std(M(:,1));
ET_fort = std(M(:,2));

%% (c) 
Borne_inf_bier = Moy_bier - ET_bier;
Borne_sup_bier = Moy_bier + ET_bier;
Borne_inf_fort = Moy_fort - ET_fort;
Borne_sup_fort = Moy_fort + ET_fort;

Cnt_anormal_bier = 0;
Cnt_anormal_fort = 0;

for i = 1:100
    if(M_red(i, 1) < Borne_inf_bier || M_red(i, 1) > Borne_sup_bier)
        Cnt_anormal_bier = Cnt_anormal_bier + 1;
    end
    
    if(M_red(i, 2) < Borne_inf_fort || M_red(i, 2) > Borne_sup_fort)
        Cnt_anormal_fort = Cnt_anormal_fort + 1;
    end
end

Prop_anormal_bier = Cnt_anormal_bier / siz(1)
Prop_anormal_fort = Cnt_anormal_fort / siz(1)

%% (d)
figure

%boxplot(M(:,1));
%boxplot(M(:,2));

%ou

boxplot(M_red)

Q1_bier=quantile(M(:,1),0.25);
Q3_bier=quantile(M(:,1),0.75);

Q1_fort=quantile(M(:,2),0.25);
Q3_fort=quantile(M(:,2),0.75);

Moust_sup_fort = Q3_fort +1.5*(Q3_fort-Q1_fort);
Moust_inf_fort = 0;

for i = 1:100
    if(M_red(i, 2) > Moust_sup_fort || M_red(i, 2) < Moust_inf_fort)
        M_red(i, 2);
    end
end

%% (e)

Conso_bier = 0:max(M_red(:,1));

Freq_bier = zeros(1, max(M_red(:,1)) + 1);

for i=1:100
    Freq_bier(1, M_red(i, 1) + 1) = Freq_bier(1, M_red(i, 1) + 1) + 1;
end

Freq_bier = Freq_bier / 100;
Freq_bier = cumsum(Freq_bier);
plot(Conso_bier, Freq_bier);

