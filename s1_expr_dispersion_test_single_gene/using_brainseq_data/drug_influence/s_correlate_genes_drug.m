load('../brainSeqP1_median_plus_residuals.mat')
groupid=[zeros(size(Dc,2),1); ones(size(Dx,2),1)];
ndc=size(Dc,2);
ndx=size(Dx,2);

load Covinfo Cov
i_dx=Cov.Dx=="Schizo";
i_dc=Cov.Dx=="Control";

Cov_dx=Cov(i_dx,:);
Cov_dc=Cov(i_dc,:);




a=readtable('top200.txt','ReadVariableNames',false);

for k=1:200
k
targetg=string(table2cell(a(k,1)));   % targetg="PHKG1";
i=find(genid_str==targetg);
y=[Dc(i,:),Dx(i,:)];


h=figure('Visible',false); 
subplot(3,4,[1 2 3])
plot(y,'k-');
line([ndc+0.5 ndc+0.5],ylim,'color','b','LineWidth',4,'linestyle',':')
title(targetg)


subplot(3,4,4)
y=[Dc(i,:) Dx(i,:)];
g=[zeros(size(Dc(i,:))) ones(size(Dx(i,:)))];
h2=boxplot(y,g,'colors','k','symbol','','Notch','on');
set(h2(6,:),'color','k','linewidth',3);
hold on
plot(g+1.25,y,'ok','markersize',4);
set(gca,'XTickLabel',{sprintf('CTL',ndc),sprintf('SCZ',ndx)});


y_dc=Dc(i,:)';
y_dx=Dx(i,:)';

Cov_dx_v=Cov_dx.Antidepressants;

subplot(3,4,[7 8])
plot(y_dx,'-k')
hold on
i1=Cov_dx_v=="Negative";
i2=Cov_dx_v=="Positive";
ix=1:length(y_dx);
plot(ix(i1),y_dx(i1),'bs','markersize',4)
plot(ix(i2),y_dx(i2),'ro','markersize',4)
xlim([0 176])
title('Antidepressants')

Cov_dx_v=Cov_dx.Antipsychotics;
subplot(3,4,[5 6])

plot(y_dx,'-k')
hold on
i1=Cov_dx_v=="Negative";
i2=Cov_dx_v=="Positive";
ix=1:length(y_dx);
plot(ix(i1),y_dx(i1),'bs','markersize',4)
plot(ix(i2),y_dx(i2),'ro','markersize',4)
xlim([0 176])
title('Antipsychotics')
print(h,sprintf('img/%d_%s',k,targetg),'-dpng');
close(h);
end
