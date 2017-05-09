function [error]=pid_rozm(K, Ti, Td, reg_no, alfa, c, draw)
close all
%algorytm DMC z opcjonalnym uwzglêdnieniem parametrów
Upp = 0;
Ypp = 0;
Umin = -1;
Umax = 1;
Tp = 0.5;

error = 0;
%inicjalizacja sta³ych
N = 1200;

u = Upp*ones(1, N);
y = Ypp*ones(1, N);
e = zeros(1,N);

yzad(1:250) = 1;
yzad(251:500) = 3;
yzad(501:750) = 2;
yzad(751:N) = -0.07;

prevE = 0;
prevUi(1:reg_no) = 0;

mi=zeros(1, reg_no);

for k=7:N
   %symulacja obiektu
   %uchyb regulacji
   e(k)=yzad(k-1) - y(k-1);
   
   for i=1:reg_no
%         Un(i)=r2(i)*e(k-2)+r1(i)*e(k-1)+r0(i)*e(k)+u(k-1);
        uP = K(i)*e(k);
        uI = prevUi(i) + (K(i)/Ti(i)) * Tp * (prevE + e(k)) / 2;
        uD = K(i) * (Td(i)/Tp) * (e(k) - prevE);
        prevUi(i) = uI;
        Un(i) = uP + uI + uD;
   end
   prevE = e(k);
   if reg_no==2
       mi(1)=1-1/(1+exp(-alfa*(y(k)-c(1))));%0.5
       mi(2)=1/(1+exp(-alfa*(y(k)-c(1))));
       %GA: pid_rozm([0.1217 0.5],[4.4546 6.0648],[2.4853 0.6473],2,3,0.3)
   elseif reg_no==3
       mi(1)=1-1/(1+exp(-alfa*(y(k)-c(1))));%-0.05
       mi(2)=1/(1+exp(-alfa*(y(k)-c(1))))-1/(1+exp(-alfa*(y(k)-c(2))));%1.4
       mi(3)=1/(1+exp(-alfa*(y(k)-c(2))));
       %p5PID([0.21 0.08 0.11],[1 2 3],[0.01 0.5 0.7],3,10,[-0.05 1.4],false)
   elseif reg_no==4
       mi(1)=1-1/(1+exp(-alfa*(y(k)-c(1))));%-0.05
       mi(2)=1/(1+exp(-alfa*(y(k)-c(1))))-1/(1+exp(-alfa*(y(k)-c(2))));%0.5
       mi(2)=1/(1+exp(-alfa*(y(k)-c(2))))-1/(1+exp(-alfa*(y(k)-c(3))));%1.4
       mi(4)=1/(1+exp(-alfa*(y(k)-c(3))));
       %p5PID([0.12 0.14 0.13 0.1],[1 3 5 3],[0.24 2.1 0.9 0.9],4,10,[-0.05 0.5 1.4],false)
   elseif reg_no==5
       mi(1)=1-1/(1+exp(-alfa*(y(k)-c(1))));%-0.05
       mi(2)=1/(1+exp(-alfa*(y(k)-c(1))))-1/(1+exp(-alfa*(y(k)-c(2))));%0.25
       mi(3)=1/(1+exp(-alfa*(y(k)-c(2))))-1/(1+exp(-alfa*(y(k)-c(3))));%0.5
       mi(4)=1/(1+exp(-alfa*(y(k)-c(3))))-1/(1+exp(-alfa*(y(k)-c(4))));%1.4
       mi(5)=1/(1+exp(-alfa*(y(k)-c(4))));
       %p5PID([0.34 0.01 0.42 0.18 0.1],[1 1 5 2 3],[0.01 1.1 0.9 2.5 0.9],5,10,[-0.05 0.25 0.5 1.4],false)
   end
   
   u(k)=sum(Un*mi')/sum(mi);
   
   if u(k)>Umax
      	u(k)=Umax;
   elseif u(k)<Umin
        u(k)=Umin;
   end
    y(k)= symulacja_obiektu5y(u(k-5),u(k-6),y(k-1),y(k-2));

    error = error + (yzad(k) - y(k))^2;
    %zapis do pliku
end
figure
plot(y)
title('y')
hold on
plot(yzad,'r-')

if draw
    if reg_no==2
       write_to_file('2_reg_pid_y', 1:N, y)
       write_to_file('2_reg_pid_u', 1:N, u)
   elseif reg_no==3
       write_to_file('3_reg_pid_y', 1:N, y)
       write_to_file('3_reg_pid_u', 1:N, u)
   elseif reg_no==4
       write_to_file('4_reg_pid_y', 1:N, y)
       write_to_file('4_reg_pid_u', 1:N, u)
   elseif reg_no==5
       write_to_file('5_reg_pid_y', 1:N, y)
       write_to_file('5_reg_pid_u', 1:N, u)
   end
end