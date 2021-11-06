% Data for China-Hubei
table = readtable('ChinaHubei.xlsx');
data = table.China_Hubei(4:33);

day = length(data);
smoothdata = data;
smoothdata(2:day-1) = (smoothdata(2:day-1)+smoothdata(1:day-2)+smoothdata(3:day))/3;
smoothdata(2:day-1) = (smoothdata(2:day-1)+smoothdata(1:day-2)+smoothdata(3:day))/3;

figure(1); clf;
date = (0:29);
hold on
plot(date,smoothdata,'-o','linewidth',1);

figure(2); clf;
time = (1:day)';
estdata = diff(log(smoothdata(1:day)));
plot(time(1:end-1),estdata,'-o','Linewidth',1);
peak_time = 14;
control = 2;

p1 = polyfit(time(1:control),estdata(1:control),1);
p2 = polyfit(time(control:peak_time),estdata(control:peak_time),2);
p3 = polyfit(time(peak_time:end-1),estdata(peak_time:end),3);
rho = zeros(day,1);
for i = 1:day
    if i <= control
        rho(i) = polyval(p1,i);
    elseif i <= peak_time
        rho(i) = polyval(p2,i);
    else
        rho(i) = polyval(p3,i);
    end
end
figure(2); hold on;
plot(time(1:end),rho);

tspan = [1,day];
[t,y] = ode45(@(t,y) deriv(t,y,rho),tspan,data(1));
figure(3); clf;
plot(time,smoothdata,'-o','Linewidth',1);
hold on;
plot(t,y,'r--','Linewidth',1);
function dydt = deriv(t,y,rho)
    rhot = interp1(1:length(rho),rho,t);
    dydt = 1.25*rhot*y;
end