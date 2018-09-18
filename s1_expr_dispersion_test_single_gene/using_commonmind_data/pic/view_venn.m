T1=i_importfile('test_2_res_BrownForsythe_1_euronly.txt');
T2=i_importfile('test_2_res_BrownForsythe_2_euronly.txt');
T3=i_importfile('test_2_res_BrownForsythe_3_euronly.txt');
T4=i_importfile('test_2_res_BrownForsythe_4_euronly.txt');

k1=T1.genename;
k2=T2.genename;
k3=T3.genename;
k4=T4.genename;

intersect(k1,intersect(k2,k3))
% vennmyown(k1,k2,k3)


%%
