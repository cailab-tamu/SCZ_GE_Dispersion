function [g]=i_add_jitter(g,A)
    gx=unique(g);
    for k=1:length(gx)
       i=g==gx(k);
       g(i)=i_add_j(g(i),A(i));
    end
end
function [g]=i_add_j(g,A)        
    Q1 = quantile(A,0.25);
    Q3 = quantile(A,0.75);
    Spread = 1.5*(Q3-Q1);
    MaxValue = Q3 + Spread;
    MinValue = Q1 - Spread;
    i=~( A>MaxValue | A<MinValue);
    g(i)=g(i)+0.025*(randn(size(g(i))));
end