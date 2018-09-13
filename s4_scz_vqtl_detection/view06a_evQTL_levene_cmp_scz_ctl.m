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
T=readtable(sprintf('test06_evQTL_levene_cmp_scz_ctl_results.txt'));

for k=1:size(T,1)
    if T.Var7(k)>=1e-9, continue; end
    %if c>40, continue; end
    c=c+1;
    cgen=T.Var2{k};
    if ~strcmp('NRXN1',cgen), continue; end
    %if ~strcmp('PACSIN2',cgen), continue; end
    %if ~strcmp('RCAN1',cgen), continue; end
    % PACSIN2   RCAN1
    [~,gk]=ismember(cgen,genid);
    sk=T.Var5(k);
    gexpx=Dx(gk,:)';
    gexpc=Dc(gk,:)';
    ggnox=Gx012(:,sk)+1;
    ggnoc=Gc012(:,sk)+1;
    i_plotboxplots;
    title(sprintf('chr%d-%d',T.Var3(k),T.Var4(k)))
    line([3.5 3.5],ylim,'color','b','LineWidth',4,'linestyle',':')
    pause(2);
end
c




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
