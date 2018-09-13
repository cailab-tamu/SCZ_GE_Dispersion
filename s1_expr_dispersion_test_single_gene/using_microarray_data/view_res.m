i_common_setting;
[~,i]=ismember('VEGFA',Tgene.external_gene_id);
%[~,i]=ismember('CRH',Tgene.external_gene_id);
%[~,i]=ismember('FABP5P2',Tgene.external_gene_id);
%[~,i]=ismember('RARRES3',Tgene.external_gene_id);

ndc=size(Dc,2);
ndx=size(Dx,2);

%%
figure;
subplot(2,1,1)
plot([Dc(i,:) Dx(i,:)],'k-')
xlim([-1 ndc+ndx+1]);
ylabel('VEGFA')
line([ndc+0.5 ndc+0.5],ylim,'color','b','LineWidth',4,'linestyle',':')

%%
figure;
subplot(2,2,1)
y=[Dc(i,:) Dx(i,:)];
g=[zeros(size(Dc(i,:))) ones(size(Dx(i,:)))];
h2=boxplot(y,g,'colors','k','symbol','','Notch','on');
set(h2(6,:),'color','k','linewidth',3);
hold on
plot(g+1.25,y,'ok');
set(gca,'XTickLabel',{sprintf('CTL (n=%d)',ndc),sprintf('SCZ (n=%d)',ndx)});
ylabel('VEGFA')
% vartestn(y',g','TestType','LeveneQuadratic','display','off')
% vartestn(y',g','TestType','LeveneAbsolute','display','off')
p=vartestn(y',g','TestType','BrownForsythe','display','off')

