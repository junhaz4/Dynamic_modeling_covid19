function SEIR(N,alpha,beta,mu,time)
tspan = [0, time];
R0 = 0;
I0 = 0;
E0 = 1/N;
S0 = 1-(1/N);
y0 = [S0; E0; I0; R0;];
[t,y] = ode45(@(t,y) deriv(t,y,alpha,beta,mu), tspan, y0);
plot(t,y(:,1),'r-',t,y(:,2),'m-', t,y(:,3),'g-', t,y(:,4),'b-');
legend('Suspectible','Exposed','Infectious','Recovered');
function dydt = deriv(~,y,alpha,beta,mu)
    dydt = [-beta*y(1)*y(3);...
        -beta*y(1)*y(3)-alpha*y(2);...
        alpha*y(2)-mu*y(3);...
        mu*y(3);];
end
end