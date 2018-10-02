% drugid='DB00408';
% urlbase='https://bioinfo.uth.edu/SZGR/displayDrugTarget.do';
% % url=sprintf('%s?drugid=%s',urlbase,drugid);
% data = webread(urlbase,'drugid','DB00408','duration',7);
% % a=webread(url);
% % b=urlread(url)
% webread('https://bioinfo.uth.edu/SZGR/displayDrugTarget.do?drugid=DB00408')
% urlread('https://bioinfo.uth.edu/SZGR/displayDrugTarget.do?drugid=DB00408')

drug_targets=["SLC18A2","SLC18A1","DRD2","HTR2A","DRD1","DRD5","DRD3","DRD4","HTR1A","HTR1B","HTR1D","HTR1E","HTR2C","HTR3A","HTR6","HTR7","HRH1","ADRA1A","ADRA1B","ADRA2A","ADRA2B","ADRA2C","CHRM1","CHRM2","CHRM3","CHRM4","CHRM5","ADRA1D","HTR2B","HTR5A","HRH4","GABRA1","ADRB1","CALY","SLC6A4","SLC6A2","SLC6A3","SIGMAR1","KCNH2","SMPD1","CALM1","GRIN2B","TNNC1","HTR4","OPRM1","TSPO","CYP3A4","CYP2D6","CYP3A5"];
Tori=readtable(sprintf('test06_evQTL_levene_cmp_scz_ctl_results.txt'));
T=sortrows(Tori,7);
[~,idx]=unique(T.Var2,'stable');
T=T(idx,:);

[genes,~,j]=intersect(drug_targets,string(T.Var2));
Tx=T(j,:);

for k=1:length(genes)
    copyfile(sprintf('img/%s.png',genes(k)),'./');
end

%%

T=readtable(sprintf('test06_evQTL_levene_cmp_scz_ctl_results.txt'));
length(unique(T.Var2))
T2=T(T.Var7<1e-7,:);
length(unique(T2.Var2))
T2=sortrows(T2,7);
T2=sortrows(T2,2);
writetable(T2(:,2:end),'SCZ_evQTL_table.txt');

%%
glist=string(unique(T2.Var2));
for k=1:length(glist)
    movefile(sprintf('img/%s.png',glist(k)),'img2/');
end

%%
glist=["FAM65B","CD36","ANXA11","SND1","PSMB2","LRFN3","BRMS1","GSTO1","MAPK8","ABHD14A","CNTNAP2"];
for k=1:length(glist)    
    copyfile(sprintf('img2/%s.png',glist(k)),'img_paper/');
end

%%
T=readtable(sprintf('test07_evQTL_levene_cmp_ctl_scz_results.txt'));
length(unique(T.Var2))
T2=T(T.Var6<1e-7,:);
length(unique(T2.Var2))



