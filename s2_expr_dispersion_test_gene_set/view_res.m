setid=4;
i_common_setting;

nctl=size(Dc,2);
ndiz=size(Dx,2);
isdiz=logical([zeros(nctl,1);ones(ndiz,1)]);
dizgroup=1+isdiz;
% addpath('C:\Users\jcai\Documents\GitHub\My_Code\Mahalanobis_Distance\Robust_MD');
% addpath('\\wdxtba361-1\disk4t\CommonMind\levene_test')
%%
targetsetid=5525;
%targetsetid=10600;

    gszmax=min([floor(nctl/2) floor(ndiz/2)]);
    c=0;
    for k=1:m_setnum
        if k~=targetsetid, continue; end
        if ~strcmp(GeneSetName{k}(1:3),'GO_'), continue; end
        fprintf('%d\t%d......%d\n',setid,k,m_setnum);
        i=ismember(genid,GeneSet{k});
        gszn=sum(i);
        
        if gszn<gszmax && gszn>=5
            c=c+1;
            Z0=Dc(i,:)';
            Z1=Dx(i,:)';

            [~,~,mah0] = robustcov(Z0,'OutlierFraction',0.5);
            [~,~,mah1] = robustcov(Z1,'OutlierFraction',0.5);
            
            z=[mah0;mah1];            
            [p1] = anova1(z,dizgroup,'off');
            [p2] = anova1(z.^2,dizgroup,'off');
            p=min([p1 p2])
            
            dtag="  ...  ";
            if p1<0.06|| p2<0.06
                if std(mah1)>std(mah0)
                    dtag="scz>ctl";
                else
                    dtag="scz<ctl";
                end
            end

        end
    end
    

setgene=string(GeneSetName{targetsetid})';
setname=string(GeneSetName{targetsetid})';
Zctl=Z0;
Zscz=Z1;
mah_ctl=mah0;
mah_scz=mah1;
% save scz_geneset_example setgene setname Zctl Zscz mah_ctl mah_scz targetsetid
% 1-hygecdf(12,5020,216,95)

X=[Z0; Z1];
[~,s]=pca(X);

%%
figure;

subplot(2,2,3)
xy1=[s(1:nctl,1),s(1:nctl,2)];
xy2=[s(nctl+1:end,1),s(nctl+1:end,2)];
i_plotpca(xy1,xy2)
xlabel('PC 1')
ylabel('PC 2')
oldxlim=xlim;
oldylim=ylim;



subplot(2,2,1)
xy1=[s(1:nctl,1),s(1:nctl,2)];
xy2=[s(nctl+1:end,1),s(nctl+1:end,2)];
    p1=plot(xy1(:,1),xy1(:,2),'bo','markersize',5);
    hold on
    p2=plot(xy2(:,1),xy2(:,2),'w.','markersize',1);
    %set(p1,'visible','off')
xlabel('PC 1')
ylabel('PC 2')
xlim(oldxlim)
ylim(oldylim)

    line([0 0],ylim,'color','k','LineStyle',':','linewidth',1.2);
    line(xlim,[0 0],'color','k','LineStyle',':','linewidth',1.2);
title('CTL')
    
subplot(2,2,2)
xy1=[s(1:nctl,1),s(1:nctl,2)];
xy2=[s(nctl+1:end,1),s(nctl+1:end,2)];
    p1=plot(xy1(:,1),xy1(:,2),'w.','markersize',1);
    hold on
    p2=plot(xy2(:,1),xy2(:,2),'ro','markersize',5);
    %set(p2,'visible','on')
xlabel('PC 1')
ylabel('PC 2')
xlim(oldxlim)
ylim(oldylim)

    line([0 0],ylim,'color','k','LineStyle',':','linewidth',1.2);
    line(xlim,[0 0],'color','k','LineStyle',':','linewidth',1.2);
title('SCZ')



% subplot(2,3,4)
% xy1=[s(1:nctl,2),s(1:nctl,3)];
% xy2=[s(nctl+1:end,2),s(nctl+1:end,3)];
% i_plotpca(xy1,xy2)
% xlabel('PC 2')
% ylabel('PC 3')

subplot(2,2,4)
i_evqtlplot(z,dizgroup-1);
% ylabel('Mahalanobis distance to group centroid')
ylabel('MD to group centroid')
% subplot(2,3,5)
% boxplot(z,agegroup);
% hold on
% plot(agegroup+randn(length(z),1)*0.009,z,'o');

% x=10:20:2500;
% c=1;
% p=ones(size(x));
% for k=10:20:2500, p(c)=-log10(1-hygecdf(sum(a(1:k)),length(a),length(a(1:k)),sum(a))); c=c+1; end
% plot(x,p,'o-')



function i_plotpca(xy1,xy2)
    plot(xy1(:,1),xy1(:,2),'bo','markersize',5);
    hold on;

    % return;
    error_ellipse(cov(xy1),mean(xy1),'conf',0.99,'style','b:');
       %plot(mean(xy(:,1)),mean(xy(:,2)),'b+','markersize',20);
    plot(xy2(:,1),xy2(:,2),'ro','markersize',5);
       error_ellipse(cov(xy2),mean(xy2),'conf',0.99,'style','r:');
    %plot(mean(xy(:,1)),mean(xy(:,2)),'+r','linewidth',5);

      %  axis tight
    line([0 0],ylim,'color','k','LineStyle',':','linewidth',1.2);
    line(xlim,[0 0],'color','k','LineStyle',':','linewidth',1.2);
end


function i_evqtlplot(y,g,colorid)
if nargin<3
    colorid=1;
end
    c1=[0.70196 0.78039 1]; 
    c2=[1 0.6 0.78431]; 
    c3=[.8 .8 .8];
    %colorod=get(gca,'colororder');
    %c2=defaultcolor(2);
 switch colorid
     case 1
         c=c1;
     case 2
         c=c2;
     case 3
         c=c3;
     otherwise
         c='k';
 end
        %defaultc=get(gca,'ColorOrder');
        defaultc=get(groot,'DefaultAxesColorOrder');
        c=defaultc(colorid,:);
        %plot(1+g+0.1*(rand(size(g))-0.5),y,'o','linesmooth','off','color',c)
        %plot(1+g+0.1*(rand(size(g))-0.5),y,'o','color',c)
        
        %hold on
        g=double(g);
        h2=boxplot(y,g,'colors','k','Notch','on',...
            'boxstyle','outline','symbol','');
        set(h2(6,:),'color','k','linewidth',3);
        
        hold on
        % plot(g+1+randn(size(g))*0.025,d2,'o','color','k');
        %pp1=plot(1+g+0.1*(rand(size(g))-0.5),y,'o','color',c);
        %pp1=scatter(1+g+0.1*(rand(size(g))-0.5),y);
        [gxx]=i_add_jitter(g,y);
        %pp1=scatter(1+g+0.025*(randn(size(g))),y);
        pp1=plot(g+1.25,y,'ok');
        %pp1.Color=[0 0 1];
        %pp1.MarkerEdgeColor=[0 0 0 0.2];
        % pp1.MarkerSize=20;
        
          %pp1.MarkerFaceAlpha=0.3;
        
        %set(h2,'linesmooth','off','linewidth',1.5);
        box on
        hold off
        set(gca,'XTickLabel',{'CTL','SCZ'})
        
        % http://stackoverflow.com/questions/21999451/how-to-get-the-values-of-the-outliers-and-their-coordinates-from-a-box-plot
end

function [g]=i_add_jitter(g,A)
    gx=unique(g);
    for k=1:length(gx)
       i=g==gx(k);
       g(i)=i_add_j(g(i),A(i));
    end
end

function [g]=i_add_j(g,A)        
    Q1 = quantile(A,0.25);
    Q3 = quantile(A,0.75);
    Spread = 1.5*(Q3-Q1);
    MaxValue = Q3 + Spread;
    MinValue = Q1 - Spread;
    i=~( A>MaxValue | A<MinValue);
    g(i)=g(i)+0.025*(randn(size(g(i))));
end
