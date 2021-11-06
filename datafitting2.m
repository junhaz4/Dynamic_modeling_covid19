% Data for Hubei
table = readtable('ChinaHubei.xlsx');
data = table.Hubei(1:60);

day = length(data);
smoothdata = data;
smoothdata(2:day-1) = (smoothdata(2:day-1)+smoothdata(1:day-2)+smoothdata(3:day))/3;
smoothdata(2:day-1) = (smoothdata(2:day-1)+smoothdata(1:day-2)+smoothdata(3:day))/3;

figure(1); clf;
date = datetime(2020,1,17)+caldays(0:day-1);
hold on
plot(date,smoothdata,'-o','linewidth',1);

figure(2); clf;
time = (1:day)';
estdata = log(smoothdata(1:day));
plot(time,estdata,'-o','Linewidth',1);

p1 = polyfit(time(6:11),estdata(6:11),1);
%plot(time(6:11)-1,polyval(p1,time(6:11))+0.5,'r--')
p2 = polyfit(time(11:20),estdata(11:20),1);
%plot(time(11:20)-1,polyval(p2,time(11:20))+0.5,'r--')
p3 = polyfit(time(44:end),estdata(44:end),1);
%plot(time(44:end)-1,polyval(p3,time(44:end))+0.5,'r--')
rho1 = p1(1);
rho2 = p2(1);
rho3 = p3(1);
peak_time = 20;
control_time = 11;
start_time = 6;
test_time = 27;
tspan=[6 59];

[t,y] = ode45(@(t,y) deriv(t,y,control_time,peak_time,test_time,rho1,rho2,rho3),...
              tspan, data(start_time));
figure(3);
plot(t,y,'b--','Linewidth',1);
hold on;
plot(time,smoothdata,'-o','Linewidth',1);

function dydt = deriv(t,y,control_time,peak_time,test_time,rho1,rho2,rho3)
if t >= control_time && t <=peak_time
    rhot = rho1;
elseif t >= peak_time && t <= test_time
    rhot = rho2;
else t >= test_time;
    rhot = rho3;
end
dydt = 1.35*rhot*y;
end
