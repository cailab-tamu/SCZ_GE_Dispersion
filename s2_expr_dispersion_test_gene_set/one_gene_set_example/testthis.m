load scz_geneset_example.mat
n0=size(Zctl,1);
n1=size(Zscz,1);
dizgroup=1+([zeros(n0,1);ones(n1,1)]);
%[~,~,mah0] = robustcov(Zctl,'OutlierFraction',0.5);
%[~,~,mah1] = robustcov(Zscz,'OutlierFraction',0.5);
%z=[mah0;mah1];
z=[mah_ctl;mah_scz];
[p1] = anova1(z,dizgroup,'off')
[p2] = anova1(z.^2,dizgroup,'off')
            
%%
X=[Zctl; Zscz];
[~,s]=pca(X);
figure;
scatter(s(:,1),s(:,2),20,dizgroup,'filled')
xlabel('PC 1')
ylabel('PC 2')
