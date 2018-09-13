load All_datasets_combined_092017_11245x625.mat
idx0=strcmp(Tsmpl.Group,'CTL');
idx1=strcmp(Tsmpl.Group,'SCZ');
Dc=table2array(Texpr(:,idx0));
Dx=table2array(Texpr(:,idx1));
genid=Tgene.external_gene_id;

