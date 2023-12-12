function [W,iter]=PCAL1(x,nPV)
% Calculate multiple projection vectors for PCA-L1.
% 2022-6-25 21:20:17

[W0,~,~]=svd(x,0); 
d=size(x,1);
W=zeros(d,nPV);
for iPV=1:nPV
    % initializaiton
    w=W0(:,iPV);
    f=norm(x'*w);  
    err=1;
    iter=0;
    
    % update rule
    while err>1e-4 && iter<100
        w=x*sign(x'*w);
        w=w/norm(w);

        f0=f;
        f=norm(x'*w);  % objective function value
        err=abs(f-f0)/f0;  % relative error
        iter=iter+1;  % iteration number
    end
    W(:,iPV)=w;
    x=(eye(d)-W*W')*x; % deflating
end