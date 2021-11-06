% we approximate S by S0, which is 1
% Then we focus on dI/dt = beta*I(t-r1)-gamma*I
%                  dS/dt = -beta*I(t-r1)
% Here we can choose different parameters for gamma,tcontrol,beta and delay
% and get the most practical parameter to approximate the Infectious
function DDE_I
gamma = 0.25;
R0 = 2.5;
tspan = [0 150];
tcrt = 20;
beta = [R0*gamma,gamma-0.005];
lags = [10,2];
sol = dde23(@(t,y,Z) ddefunc(t,y,Z,beta,gamma,tcrt),lags,@yhist,tspan);
plot(sol.x,sol.y);
legend('Delayed Infectious');
xlabel('time');
ylabel('Population');

function dydt = ddefunc(t,y,Z,beta,gamma,tcrt)
    ylag1 = Z(:,1);
    ylag2 = Z(:,2);
    if t < tcrt
        dydt = beta(1)*ylag1-gamma*ylag2;
    else
        dydt = beta(2)*ylag1-gamma*ylag2;
    end
end

function h = yhist(t)
    h = 0.0001;
end
end

% Here I tried to implement delayI into the SIR model
% But it didn't produce a good result
%{
function sirdelay(I0,lags,tcrt,trend)
tspan = [0 trend];
gamma = 0.25;
R_0 = 2.5;
beta = [R_0*gamma,gamma-0.001];
S0 = 1-I0;
R0 = 0;
sol = dde23(@(t,y,Z) ddefunc(t,y,Z,beta,gamma,tcrt),lags,@yhist,tspan);
plot(sol.x,sol.y);
legend('Suspectible','Infectious','Recovered');
title('delayed SIR');

function dydt = ddefunc(t,y,Z,beta,gamma,tcrt)
    ylag = Z(:,1);
    if t < tcrt
        dydt = [-beta(1)*y(1)*ylag(2);...
                beta(1)*y(1)*ylag(2)-gamma*y(2);...
                gamma*y(2);];
    else
        dydt = [-beta(2)*y(1)*ylag(2);...
                beta(2)*y(1)*ylag(2)-gamma*y(2);...
                gamma*y(2);];
    end
end
function h = yhist(t)
    h = [S0;I0;R0;];
end 
end 
%}