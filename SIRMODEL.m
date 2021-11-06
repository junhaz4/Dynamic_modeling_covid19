function SIRMODEL(N,I0,beta,mu,time)
tspan = [0, time];
R0 = 0;
S0 = N-I0;
y0 = [S0; I0; R0;];
[t,y] = ode45(@(t,y) deriv(t,y,N,beta,mu), tspan, y0);
plot(t,y(:,1),'r-',t,y(:,2),'m-', t,y(:,3),'g-');
legend('Suspectible','Infectious','Recovered');
function dydt = deriv(~,y,N,beta,mu)
    dydt = [-beta/N*y(1)*y(2); beta/N*y(1)*y(2)-mu*y(2); mu*y(2)];
end
end




 
