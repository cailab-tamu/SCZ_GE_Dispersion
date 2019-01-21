setid=3;
euronly=true;
i_common_setting;

n_genelistlen=size(Dx,1);
genid=string(genid);

%%

load CMC_214_SCZ_212_CTL_eur_geno.mat Gx012 Gc012 snv_* 
snv_pos=double(snv_pos_hg19grch37);
snv_chrid=double(snv_chrid);
fc=0.5*nansum(Gc012)./sum(~isnan(Gc012));
fx=0.5*nansum(Gx012)./sum(~isnan(Gx012));


%%

c=0;

Tori=readtable(sprintf('test06_evQTL_levene_cmp_scz_ctl_results.txt'));
T=sortrows(Tori,7);
[~,idx]=unique(T.Var2,'stable');
T=T(idx,:);
%%
close all
addlabels=true;
for k=1:size(T,1)
    %if T.Var7(k)>=1e-8, continue; end
    %if c>40, continue; end
    cgen=T.Var2{k};
    % if ~strcmp('NRXN1',cgen), continue; end
    %if ~strcmp('PACSIN2',cgen), continue; end
    %if ~strcmp('RCAN1',cgen), continue; end
    % PACSIN2   RCAN1
    
    % FAM65B CD36 ANXA11  PSMB2 LRFN3 BRMS1 GSTO1
    % MAPK8 ABHD14A 
    
    % CHDH COCH
    % CFB  CNTNAP2  SND1 CRBN DLG1 EEF1D  KCNK3 PDIA3 ZBED9
    
    
    % CALM1 HTR1A  NDUFAF5    
    % if ~strcmp('SLC39A8',cgen),  continue; end    % https://jamanetwork.com/journals/jamapsychiatry/fullarticle/2720422
    if ~strcmp('ZBED9',cgen), continue; end
    
    [~,gk]=ismember(cgen,genid);
    sk=T.Var5(k);
    gexpx=Dx(gk,:)';
    gexpc=Dc(gk,:)';
    ggnox=Gx012(:,sk)+1;
    ggnoc=Gc012(:,sk)+1;
    fh=figure('visible','on');
    i_plotboxplots;
    line([3.5 3.5],ylim,'color','b','LineWidth',4,'linestyle',':')
    if addlabels
        title(sprintf('%s - chr%d:%d (hg19)',...
              T.Var2{k},T.Var3(k),T.Var4(k)));
    end   
    % pause(2);
    %saveas(fh,sprintf('img/%s.png',T.Var2{k}));
    %close(fh);
    
end





%%

%{
for gk=11:20 %length(genid),
      gk
      genid(gk)
      tic;
      Tx=T(ismember(T.Var1,genid(gk)),:);
      for sk=1:length(fc)
		if fc(sk)<=0.15 || fx(sk)<=0.15, continue; end
		if ~any(snv_chrid(sk)==T.Var2 & snv_pos(sk)==T.Var3), continue; end

        pause
      end
      toc;
end
%}



