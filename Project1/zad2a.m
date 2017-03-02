%odpowiedzi skokowe
%skok w chwili k = 10 (11?)

clear all
N = 150;
Upp = 0.9;
Ypp = 3;
skoki = [1.2 1.1 1 0.8 0.6];
U(1:10) = Upp;
U(11:N) = 0.6;
Y(1:11) = Ypp;

for skok = skoki
   U(11:N) = skok;
   for k = 12:N
       Y(k)=symulacja_obiektu2Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
   end
   hold on
   plot(Y)
end

legend(string(skoki))
legend('boxoff')
legend('location', 'northwest')
xlabel('czas')
ylabel('wyjście (y)')