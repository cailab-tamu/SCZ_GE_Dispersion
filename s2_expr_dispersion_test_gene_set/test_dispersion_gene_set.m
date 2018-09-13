for setid=3:4
i_common_setting;

nctl=size(Dc,2);
ndiz=size(Dx,2);
isdiz=logical([zeros(nctl,1);ones(ndiz,1)]);
dizgroup=1+isdiz;

%%
T=table;
    gszmax=min([floor(nctl/2) floor(ndiz/2)]);
    c=0;
    parfor k=1:m_setnum
        if ~strcmp(GeneSetName{k}(1:3),'GO_'), continue; end
        fprintf('%d\t%d......%d\n',setid,k,m_setnum);
        i=ismember(genid,GeneSet{k});
        gszn=sum(i);
        if gszn<gszmax && gszn>=5
            c=c+1;
            Z0=Dc(i,:)';
            Z1=Dx(i,:)';            
            [~,~,mah0] = robustcov(Z0,'OutlierFraction',0.5);
            [~,~,mah1] = robustcov(Z1,'OutlierFraction',0.5);
            z=[mah0;mah1];            
            [p1]=anova1(z,dizgroup,'off');
            [p2]=anova1(z.^2,dizgroup,'off');
            p=min([p1 p2]);
            dtag="  ...  ";
            if p<=0.05
                if std(mah1)>std(mah0)
                    dtag="scz>ctl";
                else
                    dtag="scz<ctl";
                end
            end            
            if has_keywords(GeneSetName{k},...
                    {'NEUR','BRAIN','CORTEX','CEREBE','DOPAM','SYNAP','BEHAV'})
                neurtag=1;
            else
                neurtag=0;
            end
            T=[T; {k,p,dtag,gszn,length(GeneSet{k}),GeneSetName{k},neurtag}];            
        end
    end
    
T.Properties.VariableNames={'ID' 'p' 'direction' 'gszn' 'SetSize' 'SetName' 'key'};
T=sortrows(T,2);
writetable(T,sprintf('res_%d.txt',setid),'Delimiter','\t');
end


%1-hygecdf(12,5020,216,95)


function yes=has_keywords(a,b)
    yes=false;
    for k=1:length(b)
        if contains(a,b{k})
           yes=true;
           return;
        end
    end
end


