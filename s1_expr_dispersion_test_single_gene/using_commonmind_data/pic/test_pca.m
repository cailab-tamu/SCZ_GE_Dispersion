setid=4;
i_common_setting;

a=median([Dc Dx],2);
i=a>prctile(a,15);
Dx=Dx(i,:); Dc=Dc(i,:); genid=genid(i);
nctl=size(Dc,2);
ndiz=size(Dx,2);
isdiz=logical([zeros(nctl,1); ones(ndiz,1)]);
Dcx=[Dc Dx];

[~,score,~,~,explained]=pca(Dcx');
figure()
plot(score(1:nctl,1),score(1:nctl,2),'x')
hold on
plot(score(nctl+1:end,1),score(nctl+1:end,2),'r+')
xlabel(sprintf('PCA axis 1 (%.2f%%)',explained(1)))
ylabel(sprintf('PCA axis 2 (%.2f%%)',explained(2)))
line([0 0],ylim,'color',[.5 .5 .5])
line(xlim,[0 0],'color',[.5 .5 .5])

d=mahal(score(:,1:20),score(:,1:20));
[~,idx]=maxk(d,20);
isdiz(idx)=[];
Dc=Dcx(:,~isdiz);
Dx=Dcx(:,isdiz);
Dcx=[Dc Dx];
[~,score,~,~,explained]=pca(Dcx');
figure()
plot(score(1:nctl,1),score(1:nctl,2),'x')
hold on
plot(score(nctl+1:end,1),score(nctl+1:end,2),'r+')
xlabel(sprintf('PCA axis 1 (%.2f%%)',explained(1)))
ylabel(sprintf('PCA axis 2 (%.2f%%)',explained(2)))
line([0 0],ylim,'color',[.5 .5 .5])
line(xlim,[0 0],'color',[.5 .5 .5])
