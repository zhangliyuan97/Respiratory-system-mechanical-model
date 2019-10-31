clc; 

% initial the time scale
t_in = 0:0.01:0.94;
t_out = 0.94:0.01:4;
t = 0:0.01:4;

% Integrate the equations
[t1,v1] = ode45(@Inhale,t_in,0);
[t2,v2] = ode45(@Exhale,t_out,v1(end));

% Calculate the Velocity V'
v_1=Inhale(t1,v1);
v_2=Exhale(t2,v2);

% Calculate the force by muscle
p_mus = -5*sin(pi*t/0.9).*(t>=0&t<0.45)-5*sin(pi*(t-0.3)/0.3).*(t>=0.45&t<0.6)+0.*(t>=0.6&t<=4);

% Calculate the airway opening pressure   
p_ao_in = 5+17*(1-exp(-t1/0.3));
p_ao_ex = -2*v_2(int16(t2*100)-93,1)+5;

% Merge data of the airway opening pressure of inhalation and exhalation.
p_ao = [p_ao_in;p_ao_ex(2:end)]; 

% Display the results
figure(1);subplot(3,1,3),plot(t1,v1,t2,v2);
xlabel('Time(s)','FontSize',12);
ylabel('Volume Results(L)','FontSize',12);
axis([0 4 0 0.8]);

subplot(3,1,1),plot(t,p_ao,'-',t,p_mus,'--');
xlabel('Time(s)','FontSize',12);
ylabel('Pressure Results(cmH2O)','FontSize',12);
legend('Pao','Pmus');
axis([0 4 -10 25]);

subplot(3,1,2),plot(t_in,v_1,t_out,v_2);
xlabel('Time(s)','FontSize',12);
ylabel('FLow(L/s)','FontSize',12);
axis([0 4 -2 2]);