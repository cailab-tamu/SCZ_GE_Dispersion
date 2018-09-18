setid=4;
i_common_setting;
T=i_importfile(sprintf('test_res_%d.txt',setid));
targetgenes=T.genename;
%%
for k=1:length(targetgenes)
    targetg=targetgenes{k};
    [~,i]=ismember(targetg,genid);
    ndc=size(Dc,2);
    ndx=size(Dx,2);

    fh1 = figure;
    fh1.Units = 'inches';
    fh1.PaperPosition = [0 0 10 2.5];
    plot([Dc(i,:) Dx(i,:)],'k-')
    xlim([-1 ndc+ndx+1]);
    ylabel(targetg)
    sp=' ';
    for ix=1:90, sp=sprintf('%s ',sp); end
    xlabel(sprintf('CTL%sSCZ',sp));
    line([ndc+0.5 ndc+0.5],ylim,'color','b','LineWidth',4,'linestyle',':')
    y=[Dc(i,:) Dx(i,:)];
    g=[zeros(size(Dc(i,:))) ones(size(Dx(i,:)))];
    p=vartestn(y',g','TestType','BrownForsythe','display','off');
    title(sprintf('%s    %.2e',targetg,p));
    print(fh1,'pic/1','-dtiff');
    close(fh1);    
    
    fh2=figure;
    u = fh2.Units;
    fh2.Units = 'inches';
    fh2.PaperPosition = [0 0 3.5 2.5];     
    y=[Dc(i,:) Dx(i,:)];
    g=[zeros(size(Dc(i,:))) ones(size(Dx(i,:)))];
    h2=boxplot(y,g,'colors','k','symbol','','Notch','on');
    set(h2(6,:),'color','k','linewidth',3);
    hold on
    plot(g+1.25,y,'ok');
    set(gca,'XTickLabel',{sprintf('CTL (n=%d)',ndc),sprintf('SCZ (n=%d)',ndx)});
    ylabel(targetg)
    print(fh2,'pic/2.tif','-dtiff');
    close(fh2);
    I1 = imread(sprintf('pic/1.tif',targetg));
    I2 = imread(sprintf('pic/2.tif',targetg));
    imwrite([I1 I2],sprintf('pic/%s.tif',targetg));
end



