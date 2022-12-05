%% MAE 598: Design Optimisation
% Homework 5 Solution
%
% Problem 1

clc; clear all;

% Defining functions and constraints
func= @(x)x(1)^2+(x(2)-3)^2;
dfd = @(x)[2*x(1),(x(2)-3)*2];
g = @(x)[x(2)^2-2*x(1);(x(2)-1)^2+5*x(1)-15];
dgd = @(x)[-2 2*x(2); 5 2*(x(2)-1)];

% Declaring parameters
er=1e-3; % Error tolerance 
x0=[1;1]; % Initial guess
x=x0;

% Calculating required variables
W=eye(length(x)); % Hessian
mew=zeros(size(g(x))); % μ
wts=zeros(size(g(x))); % Weights of the merit function
lgr=norm(dfd(x)+mew'*dgd(x)); % Norm of the Lagrangian

while lgr>er
    % Initialising the in-built quadratic programming solver
    options = optimoptions('quadprog','Algorithm','active-set');
    [s,~,~,~,lambda] = quadprog(W,dfd(x)',dgd(x),-g(x),[],[],[],[],x,options); % Calculating the s and lambda from solver
    mew1=lambda.ineqlin; % Extracting μ from the output lambda

    % Linesearch steps
    wts = max(abs(mew),0.5*(wts+abs(mew))); % Calculating weights
    alpha=lineSearch(func,dfd,g,dgd,x,s,wts); 
    sk=alpha*s; x1=x+sk; % Advancing x

    %BFGS
    dlgrd=[dfd(x1)+mew1'*dgd(x1)-dfd(x)+mew1'*dgd(x)]'; % Gradient of Lagrangian
    if sk'*dlgrd >=0.2*sk'*W*sk
        theta=1;
    else
        theta=(0.8*sk'*W*sk)/(sk'*W*sk-(sk'*dlgrd));
    end

    y=theta*dlgrd+(1-theta)*W*sk;
    W=W+(y*y')/(y'*sk)-((W*sk)*(sk'*W))/(sk'*W*sk); % Updating Hessian

    mew=mew1;
    x=x1;
    lgr=norm(dfd(x)+mew'*dgd(x));

end

fprintf('The final point after minimisation efforts is calculated to be\n x1 = %f; x2 = %f',x(1),x(2))


% Function for Linesearch Algorithm for step size
function alpha = lineSearch(func,dfd,g,dgd,x,s,w)
    b=0.5; t=0.3; alpha=1;
    fa=func(x+alpha*s)+w'*abs(min(0,-g(x+alpha*s)));
    p1=func(x)+w'*abs(min(0,-g(x)));
    p2=dfd(x)*s+w'*((dgd(x)*s)).*(g(x)>0);
    phi=p1+t*alpha*p2;
    while fa>phi
        alpha=alpha*b;
        fa=func(x+alpha*s)+w'*abs(min(0,-g(x+alpha*s)));
        p1=func(x)+w'*abs(min(0,-g(x)));
        p2=dfd(x)*s+w'*((dgd(x)*s)).*(g(x)>0);
        phi=p1+t*alpha*p2;
    end
end