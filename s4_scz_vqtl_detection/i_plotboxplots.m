% 		gexpx=Dx(gk,:)';
% 		gexpc=Dc(gk,:)';
% 		ggnox=Gx012(:,sk)+1;
% 		ggnoc=Gc012(:,sk)+1;
gexpc=double(gexpc);
ggnoc=double(ggnoc);
gexpx=double(gexpx);
ggnox=double(ggnox);

p0=vartestn(gexpc,ggnoc,'TestType','BrownForsythe','Display','off');
p1=vartestn(gexpx,ggnox,'TestType','BrownForsythe','Display','off');

p0_1=vartestn(gexpc(ggnoc<3),ggnoc(ggnoc<3),'TestType','BrownForsythe','Display','off');
p1_1=vartestn(gexpx(ggnox<3),ggnox(ggnox<3),'TestType','BrownForsythe','Display','off');
p0_2=vartestn(gexpc(ggnoc~=2),ggnoc(ggnoc~=2),'TestType','BrownForsythe','Display','off');
p1_2=vartestn(gexpx(ggnox~=2),ggnox(ggnox~=2),'TestType','BrownForsythe','Display','off');
p0_3=vartestn(gexpc(ggnoc>1),ggnoc(ggnoc>1),'TestType','BrownForsythe','Display','off');
p1_3=vartestn(gexpx(ggnox>1),ggnox(ggnox>1),'TestType','BrownForsythe','Display','off');



xx=[ggnoc; ggnox+3];
yy=[gexpc; gexpx];
figure;
boxplot(yy,xx,'color','k');
hold on
      plot(xx,yy,'ok');
      xlabel(sprintf('(%.2g | %.2g %.2g %.2g)    (%.2g | %.2g %.2g %.2g)',p0,p0_1,p0_2,p0_3,p1,p1_1,p1_2,p1_3));
      ylabel(cgen);
      set(gca,'XTickLabel',{'0','1','2','0','1','2'})        
%         figure;
%         subplot(1,2,1)
%         boxplot(gexpc,ggnoc);
%         hold on
%         plot(ggnoc,gexpc,'o');
%         title('CTL')
%         xlabel(p0);
%         ylabel(cgen);
%         %set(sh1,'XTickLabel',{'0','1',2''})
%         yl1=ylim;
%         
% 	    subplot(1,2,2);
%         boxplot(gexpx,ggnox);
%         hold on
%         plot(ggnox,gexpx,'o');
%         title('SCZ')
%         xlabel(p1)
%         ylabel(cgen);     
%         %set(sh2,'XTickLabel',{'0','1',2''})    
%         yl2=ylim;
%         yl=[yl1;yl2];
%         ylim([min(yl(:)) max(yl(:))]);
%         
%         %subplot(1,2,1)
%         %ylim([min(yl(:)) max(yl(:))]);
