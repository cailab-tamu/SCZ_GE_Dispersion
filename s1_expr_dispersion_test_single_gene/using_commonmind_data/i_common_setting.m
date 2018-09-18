switch setid
case 1
        load ../../s2_expr_dispersion_test_gene_set/CMC1_214_SCZ_212_Control_eur Dx Dc genid
case 2
        load ../../s2_expr_dispersion_test_gene_set/CMC2_214_SCZ_212_Control_eur Dx Dc genid
case 3
        load ../../s2_expr_dispersion_test_gene_set/CMC3_214_SCZ_212_Control_eur Dx Dc genid
case 4
        load ../../s2_expr_dispersion_test_gene_set/CMC4_214_SCZ_212_Control_eur Dx Dc genid
end

% string({flist(1).name; flist(2).name; flist(3).name; flist(4).name})
%    "CMC_MSSM-Penn-Pitt_DLPFC_mRNA_IlluminaHiSeq2500_gene-adjustedNoSVA-dataNormalization-includeAncestry-adjustedLogCPM.zip"
%    "CMC_MSSM-Penn-Pitt_DLPFC_mRNA_IlluminaHiSeq2500_gene-adjustedNoSVA-dataNormalization-noAncestry-adjustedLogCPM.zip"
%    "CMC_MSSM-Penn-Pitt_DLPFC_mRNA_IlluminaHiSeq2500_gene-adjustedSVA-dataNormalization-includeAncestry-adjustedLogCPM.zip"
%    "CMC_MSSM-Penn-Pitt_DLPFC_mRNA_IlluminaHiSeq2500_gene-adjustedSVA-dataNormalization-noAncestry-adjustedLogCPM.zip"

%%
a=median([Dc Dx],2);
i=a>prctile(a,15);
Dx=Dx(i,:); Dc=Dc(i,:); genid=genid(i);

%%
% nctl=size(Dc,2);
% ndiz=size(Dx,2);
% isdiz=logical([zeros(nctl,1); ones(ndiz,1)]);

%% 
% Dcx=[Dc Dx];
% [~,score]=pca(Dcx');
% d=mahal(score(:,1:3),score(:,1:3));
% [~,idx]=maxk(d,20);
% isdiz(idx)=[];
% Dc=Dcx(:,~isdiz);
% Dx=Dcx(:,isdiz);

