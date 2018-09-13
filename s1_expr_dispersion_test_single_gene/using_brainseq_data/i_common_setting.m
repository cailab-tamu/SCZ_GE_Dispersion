load brainSeqP1_median_plus_residuals
genid=cellfun(@char,geneid,'uniformoutput',false);

%% Remove lowly expressed genes
% a=median([Dc Dx],2);
% i=a>prctile(a,5);
% Dx=Dx(i,:); Dc=Dc(i,:); genid=genid(i);
% %Dc=Dc(:,1:175);

%% Remove global outlying individuals
% Dx(:,[17 50 113 148 210 87 174])=[];
% Dc(:,[59 50 22 211 199 188 167])=[];
nctl=size(Dc,2);
ndiz=size(Dx,2);
isdiz=logical([zeros(nctl,1); ones(ndiz,1)]);

Dcx=[Dc Dx];
[~,score]=pca(Dcx');
d=mahal(score(:,1:5),score(:,1:5));
[~,idx]=maxk(d,14);
isdiz(idx)=[];
Dc=Dcx(:,~isdiz);
Dx=Dcx(:,isdiz);

