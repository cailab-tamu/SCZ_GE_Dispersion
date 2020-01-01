load scz_geneset_example.mat
n0=size(Zctl,1);
n1=size(Zscz,1);
dizgroup=[-1*ones(n0,1);ones(n1,1)];
X=[Zctl; Zscz];
[~,s]=pca(X,'NumComponents',2);
data1=s(dizgroup==-1,:);
data2=s(dizgroup==1,:);



project = @(data, sigma) sum(exp(-(squareform( pdist(data, 'euclidean') .^ 2) ./ ( 2*sigma^2))));



data1_z = project(data1, 2);
data2_z = project(data2, 2);


figure;

plot3(data1(:,1),data1(:,2),data1_z,'r.','MarkerSize',15)
hold on
plot3(data2(:,1),data2(:,2),data2_z,'b.','MarkerSize',15)
% ezpolar(@(x)1);ezpolar(@(x)2);
%axis equal
%hold off

theclass=dizgroup;

%Train the SVM Classifier
cl = fitcsvm(X,theclass,'KernelFunction','rbf',...
    'BoxConstraint',Inf,'ClassNames',[-1,1]);

CVSVMModel = crossval(cl,'Leaveout','off');

kfoldLoss(CVSVMModel)
% ans = 0.0769
% The out-of-sample misclassification error is approximately 8%.

% [Mdl,FitInfo] = fitckernel(X,theclass)
CVMdl = fitckernel(X,theclass,'CrossVal','on');
kfoldLoss(CVMdl)




