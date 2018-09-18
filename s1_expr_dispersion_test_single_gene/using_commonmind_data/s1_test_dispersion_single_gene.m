for setid=1:4
i_common_setting;
%test_pca;
%close all;
    groupid=[zeros(size(Dc,2),1); ones(size(Dx,2),1)];
    T=table;
    parfor k=1:length(genid)    
        y=[Dc(k,:)';Dx(k,:)'];
        [p4]=vartestn(y,groupid,'TestType','OBrien','display','off');
        [p3]=vartestn(y,groupid,'TestType','LeveneQuadratic','display','off');
        [p2]=vartestn(y,groupid,'TestType','LeveneAbsolute','display','off');
        [p1]=vartestn(y,groupid,'TestType','BrownForsythe','display','off');
        T=[T; {genid{k},p1,p2,p3,p4,std(Dx(k,:))>std(Dc(k,:))}];
    end
    T.Properties.VariableNames={'Genename' 'BrownForsythe' 'LeveneAbsolute' 'LeveneQuadratic' 'OBrien' 'std_SCZ_GT_std_CTL'};
    %idx1=T{:,2}<0.05/length(genid);
    FDR = mafdr(T{:,2});
    idx1=FDR<0.05;    
    T2=T(idx1,:);
    T3=sortrows(T2,2);
    writetable(T3,sprintf('test_res_%d.txt',setid),'Delimiter','\t');
end
