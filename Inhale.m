function dv = Inhale(t,v)

P_mus = -5*sin(pi*t/0.9).*(t>=0&t<0.45)-5*sin(pi*(t-0.3)/0.3).*(t>=0.45&t<0.6)+0.*(t>=0.6&t<=4);

dv = 1/7*(17*(1-exp(-t/0.3))-20*v-P_mus);

end

