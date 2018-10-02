load zxy2 Zc X Y
Z=cellfun(@(X)(sum(X<0.001)),Zc);
figure; mesh(X,Y,Z,'edgecolor', 'k')
zlabel('Power (%)')
xlabel('Size of samples per group')
ylabel('Factor of variance heterogeneity')

figure; contour(X,Y,Z,'showtext','on','color','k')
% https://stackoverflow.com/questions/44816434/matlab-how-to-make-smooth-contour-plot
xlabel('Size of samples per group')
ylabel('Factor of variance heterogeneity')