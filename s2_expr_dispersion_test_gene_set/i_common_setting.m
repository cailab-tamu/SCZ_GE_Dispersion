switch setid
case 1
        load CMC1_214_SCZ_212_Control_eur Dx Dc genid
case 2
        load CMC2_214_SCZ_212_Control_eur Dx Dc genid
case 3
        load CMC3_214_SCZ_212_Control_eur Dx Dc genid
case 4
        load CMC4_214_SCZ_212_Control_eur Dx Dc genid
end
% string({flist(1).name; flist(2).name; flist(3).name; flist(4).name})
%    "CMC_MSSM-Penn-Pitt_DLPFC_mRNA_IlluminaHiSeq2500_gene-adjustedNoSVA-dataNormalization-includeAncestry-adjustedLogCPM.zip"
%    "CMC_MSSM-Penn-Pitt_DLPFC_mRNA_IlluminaHiSeq2500_gene-adjustedNoSVA-dataNormalization-noAncestry-adjustedLogCPM.zip"
%    "CMC_MSSM-Penn-Pitt_DLPFC_mRNA_IlluminaHiSeq2500_gene-adjustedSVA-dataNormalization-includeAncestry-adjustedLogCPM.zip"
%    "CMC_MSSM-Penn-Pitt_DLPFC_mRNA_IlluminaHiSeq2500_gene-adjustedSVA-dataNormalization-noAncestry-adjustedLogCPM.zip"


a=median([Dc Dx],2);
i=a>prctile(a,15);
Dx=Dx(i,:); Dc=Dc(i,:); genid=genid(i);

%%
% Dx(:,[17 50 113 148 210 87 174])=[];
% Dc(:,[59 50 22 211 199 188 167])=[];

%%
load msigdb_v52_c2_c5.mat GeneSet GeneSetName
m_setnum=length(GeneSet);
n_genelistlen=size(Dx,1);

c=0;
for k=1:m_setnum
    c=c+strcmp(GeneSetName{k}(1:3),'GO_');
end
pcutoff=0.05/c;

