%% Question 2
%
%
%
%%

n=20;


%% 

M = csvread('db_stat75.csv',1,1);
siz = size(M);

if(siz(1)~= 100 || siz(2)~= 4)
    disp('ERREUR DANS LA LECTURE DU FICHIER');
end

%%


E=tirage(n,M);



Moy_E_bier = mean(E(:,1));
Moy_E_fort = mean(E(:,2));

Med_E_bier = median(E(:,1));
Med_E_fort = median(E(:,2));

ET_E_bier = std(E(:,1));
ET_E_fort = std(E(:,2));

E_red = zeros(n,2);
E_red(:,1)=E(:,1);
E_red(:,2)=E(:,2);

boxplot(E_red);

Conso_E_bier = 0:max(E_red(:,1));

Freq_E_bier = zeros(1, max(E_red(:,1)) + 1);

for i=1:n
    Freq_E_bier(1, E_red(i, 1) + 1) = Freq_E_bier(1, E_red(i, 1) + 1) + 1;
end

Freq_E_bier = Freq_E_bier / n;
Freq_E_bier = cumsum(Freq_E_bier);

figure 
plot(Conso_E_bier, Freq_E_bier);
