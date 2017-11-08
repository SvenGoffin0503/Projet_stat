%% Question 2a
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

%% (i) Moyenne

vect_E=zeros(100,n,4);

for i=1:100
    
    vect_E(i,:,:)=tirage(n,M);
    
end

Vec_moy_E_bier=zeros(100,1);
Vec_moy_E_fort=zeros(100,1);

for i=1:100
    
    Vec_moy_E_bier(i) = mean(vect_E(i,:,1));
    Vec_moy_E_fort(i) = mean(vect_E(i,:,2));
    
    Vec_med_E_bier(i) = median(vect_E(i,:,1));
    Vec_med_E_fort(i) = median(vect_E(i,:,2));
    
    Vec_ET_E_bier(i) = std(vect_E(i,:,1));
    Vec_ET_E_fort(i) = std(vect_E(i,:,2));
    
end

Vec_moy_E_bier;
Vec_moy_E_fort;

figure
histogram(Vec_moy_E_bier);
title('histograme des moy des conso des bieres');
figure
histogram(Vec_moy_E_fort);
title('histograme des moy des conso des fort');
Moy_vec_moy_bier=mean(Vec_moy_E_bier);
Moy_vec_moy_fort=mean(Vec_moy_E_fort);

figure
histogram(Vec_med_E_bier);
title('histograme des med des conso des bieres');
figure
histogram(Vec_med_E_fort);
title('histograme des med des conso des fort');
Moy_vec_med_bier=mean(Vec_med_E_bier);
Moy_vec_med_fort=mean(Vec_med_E_fort);

figure
histogram(Vec_ET_E_bier);
title('histograme des ET des conso des bieres');
figure
histogram(Vec_ET_E_fort);
title('histograme des ET des conso des fort');
Moy_vec_ET_bier=mean(Vec_ET_E_bier);
Moy_vec_ET_fort=mean(Vec_ET_E_fort);
