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

if isempty(gcp('nocreate')), parpool('local'); end

fcn = @() fopen(sprintf('test06_evQTL_levene_cmp_scz_ctl_res_%d.txt',...
    labindex),'wt' );
w = WorkerObjWrapper( fcn, {}, @fclose );

%%

for gk=1:length(genid)
      gk
      genid(gk)
      tic;
      parfor sk=1:length(fc)
        if fc(sk)<=0.15 || fx(sk)<=0.15, continue; end
            ggnox=Gx012(:,sk)+1;
        if min(grpstats(ggnox,ggnox,'length'))<10, continue; end
		gexpx=Dx(gk,:)';
		gexpc=Dc(gk,:)';
        ggnoc=Gc012(:,sk)+1;
		p0=vartestn(double(gexpc),double(ggnoc),'TestType','BrownForsythe','Display','off');
		p1=vartestn(double(gexpx),double(ggnox),'TestType','BrownForsythe','Display','off');
        
		if p0>=0.05 && p1 < 1e-6
			s=sprintf('%d\t%s\t%d\t%d\t%d\t%e\t%e',...
			   gk,genid(gk),snv_chrid(sk),snv_pos(sk),sk,p0,p1);
            fprintf( w.Value,'%s\n', s );
        end
               
      end
      toc;
end


