load scz_geneset_example.mat
n0=size(Zctl,1);
n1=size(Zscz,1);
dizgroup=1+([zeros(n0,1);ones(n1,1)]);
%[~,~,mah0] = robustcov(Zctl,'OutlierFraction',0.5);
%[~,~,mah1] = robustcov(Zscz,'OutlierFraction',0.5);
%z=[mah0;mah1];
z=[mah_ctl;mah_scz];

sigma=50;
z2=exp(-z./(2*sigma^2));

z3=z;
z3(z>7)=z3(z>7)*20;


[p1a] = anova1(z,dizgroup,'off'); [p2a] = anova1(z.^2,dizgroup,'off');
[p1b] = anova1(z2,dizgroup,'off'); [p2b] = anova1(z2.^2,dizgroup,'off');
[p1c] = anova1(z3,dizgroup,'off'); [p2c] = anova1(z3.^2,dizgroup,'off');

[p1a p1b p1c]
[p2a p2b p1c]


%%
X=[Zctl; Zscz];
[~,s]=pca(X);
figure;
scatter(s(:,1),s(:,2),20,dizgroup,'filled')
xlabel('PC 1')
ylabel('PC 2')
figure;
gscatter(s(:,1),s(:,2),dizgroup,'rb','.');