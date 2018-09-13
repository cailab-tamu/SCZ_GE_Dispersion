T6=importfile_1('test06_evQTL_levene_cmp_scz_ctl_results.txt');
T7=importfile_1('test07_evQTL_levene_cmp_ctl_scz_results.txt');
close all
figure;
qqplot(-log10(T7.p_ctl),-log10(T6.p_scz))
box on
xlabel('-log10(P) CTL')
ylabel('-log10(P) SCZ')

T6sig=T6(T6.p_scz<=1e-9,:);
T7sig=T7(T7.p_ctl<=1e-9,:);

gxset6=unique(T6sig.gname);
gxset7=unique(T7sig.gname);
