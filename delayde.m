function delayde(alpha, dt, yhis)
t = linspace(0,dt,100);
lags = 1;
sol = dde23(@ddefunc,lags,@yhist,t);
y = deval(sol,t);
figure;
plot(t,y);
function dydt = ddefunc(t,y,Z)
    dydt = alpha*y*(1-Z)
end

function y = yhist(t)
    y = yhis;
end 
end 
% The figure1 corresponds to delayde(1,100,2)
% The figure2 corresponds to delayed(0.1,100,2)
% The figure2 corresponds to delayed(3,100,2)