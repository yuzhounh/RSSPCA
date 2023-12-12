function [W,iter]=RSSPCA(x,L,e1,e2,nPV)
% Calculate multiple projection vectors for RSSPCA. 
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
        v=x*sign(x'*w);
        U=diag(abs(w));
        w=U*((U+e1*eye(d)+e2*L*U)\v);
        w=w/norm(w);

        f0=f;
        f=norm(x'*w);  % objective function value
        err=abs(f-f0)/f0;  % relative error
        iter=iter+1;  % iteration number
    end
    W(:,iPV)=w;
    x=(eye(d)-W*W')*x; % deflating
end