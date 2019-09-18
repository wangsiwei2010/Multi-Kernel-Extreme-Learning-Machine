function [radiusp]= basicRadius(K)

d=size(K,3);
n=size(K,1);

radiusp = zeros(d,1);
for p = 1:d
    H= 2 * K(:,:,p);
    f= diag(K(:,:,p));
    A=ones(n,1);
    b=1;
    B=1;
    [beta, lambdat, pos] = mymonqp(H,f,A,b,B);
    
    optimalBeta=zeros(n,1);
    optimalBeta(pos)=beta;
    
    radiusp(p) = -0.5*optimalBeta'*H*optimalBeta + f'*optimalBeta;
end
