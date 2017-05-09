function [E, Y, U]=zad6DMC(Nu,lambda,n,d,c)

%zad6DMC(Nu,lambda,n,d,c)
%zad6DMC(150,[5 2],2,[10 10], 50)

%nasz
% zad6DMC(500 , [2 1] , 2, 10, 50)

%algorytm DMC z opcjonalnym uwzgl?dnieniem parametrów
addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM3 % initialise com port
N=300;
Nu=round(Nu);
s1=csvread('skok40_approx.csv');
sn=csvread('skok80_approx.csv');
D=300;
Upp=27;
Ypp=31.5;
Umin=0;
Umax=100;

%inicjalizacja sta?ych
kk=1200;
startk=10;

%----------------------------------------------------------------

M=zeros(N,Nu);
MP=zeros(N,D-1);
I=eye(Nu);
ku=zeros(n,D-1);
ke=zeros(1,n);
for m=1:n
    if m==1
        s=s1;
    elseif m==n
%         s=sn(:,2)./10000;
        s=sn;
    elseif m==2 && n==3
        stemp=load('aprskok25.txt');
%         s=stemp(:,2)./2000;
        s=stemp(:,2);
    elseif m==2 && n==4
%         stemp=load('skok_-0.089_0.293.txt');
        stemp=load('skok_-0.089_0.377.txt');
        s=stemp(:,2);
    elseif m==3 && n==4
%         stemp=load('skok_0.293_0.502.txt');
        stemp=load('skok_0.377_0.502.txt');
        s=stemp(:,2);
    elseif m==2 && n==5
        stemp=load('skok_-0.889_0.194.txt');
        s=stemp(:,2);
    elseif m==3 && n==5
        stemp=load('skok_0.194_0.377.txt');
        s=stemp(:,2);
    elseif m==4 && n==5
        stemp=load('skok_0.377_0.502.txt');
        s=stemp(:,2);
    end
%     s=z2_y21(16:115,2);
    
    
    for i=1:N
        for j=1:Nu
            if (i>=j)
                M(i,j)=s(i-j+1);
            end;
        end;
    end;
    
    for i=1:N
        for j=1:D-1
            if i+j<=D
                MP(i,j)=s(i+j)-s(j);
            else
                MP(i,j)=s(D)-s(j);
            end;
        end;
    end;
    
    K=((M'*M+lambda(m)*I)^-1)*M';
    ku(m,:)=K(1,:)*MP;
    ke(m)=sum(K(1,:));
end

% Obliczanie parametrów regulatora


U(1:kk)=Upp;
Y(1:kk)=Ypp;

e=zeros(1,kk);
Yzad(1:200) = 34;
Yzad(201:400) = 37;
Yzad(401:600) = 40;
Yzad(601:800) = 43;
Yzad(801:1000) = 46;
Yzad(1001:1200) = 41;
u=U-Upp;
y=U-Ypp;
yzad = Yzad-Ypp;
umax = Umax - Upp;
umin = Umin - Upp;

deltaup=zeros(1,D-1);

Un=zeros(1,n);
mi=Un;

for k=3:kk
    %symulacja obiektu
   Y(k)= readMeasurements(1);
   y(k) = Y(k) - Ypp;
   %uchyb regulacji
   e(k)=yzad(k) - y(k);
    
    for m=1:n
        % Prawo regulacji
        Un(m)=ke(m)*e(k)-ku(m,:)*deltaup';
%         Un(m)=u(k-1)+deltauk;
    end
    if n==2
        mi(1)=1-1/(1+exp(-d(1)*(Y(k)-c(1))));%0.5
        mi(2)=1/(1+exp(-d(2)*(Y(k)-c(1))));
    elseif n==3
        mi(1)=1-1/(1+exp(-d(1)*(Y(k)-c(1))));%-0.05
        mi(2)=1/(1+exp(-d(2)*(Y(k)-c(1))))-1/(1+exp(-d(2)*(Y(k)-c(2))));%1.4
        mi(3)=1/(1+exp(-d(3)*(Y(k)-c(2))));
    elseif n==4 %100 10 30 50
        mi(1)=1-1/(1+exp(-d(1)*(Y(k)-c(1))));%-0.05
        mi(2)=1/(1+exp(-d(2)*(Y(k)-c(1))))-1/(1+exp(-d(2)*(Y(k)-c(2))));%0.5/0.8
        mi(3)=1/(1+exp(-d(3)*(Y(k)-c(2))))-1/(1+exp(-d(3)*(Y(k)-c(3))));%1.4
        mi(4)=1/(1+exp(-d(4)*(Y(k)-c(3))));
    elseif n==5 %200 40 40 30 10
        mi(1)=1-1/(1+exp(-d(1)*(Y(k)-c(1))));%-0.05
        mi(2)=1/(1+exp(-d(2)*(Y(k)-c(1))))-1/(1+exp(-d(2)*(Y(k)-c(2))));%0.25
        mi(3)=1/(1+exp(-d(3)*(Y(k)-c(2))))-1/(1+exp(-d(3)*(Y(k)-c(3))));%0.8
        mi(4)=1/(1+exp(-d(4)*(Y(k)-c(3))))-1/(1+exp(-d(4)*(Y(k)-c(4))));%1.4
        mi(5)=1/(1+exp(-d(5)*(Y(k)-c(4))));
    end
    
    deltauk=sum(Un*mi')/sum(mi);
    for i=D-1:-1:2
        deltaup(i)=deltaup(i-1);
    end
    deltaup(1)=deltauk;
    u(k)=u(k-1)+deltauk;
    
    if u(k)>umax
      	u(k)=umax;
   elseif u(k)<umin
        u(k)=umin;
   end
   U(k)=u(k)+Upp;
   
    sendNonlinearControls(U(k)) ;
    disp(k)
    disp(Y(k))
    plot(Y)
    drawnow
    %zapis do pliku
   % toPlotForLatex('lab6dmcY3',1:kk,Y);
   % toPlotForLatex('lab6dmcU3',1:kk,U);
   % toPlotForLatex('lab6Yzad',1:kk,Yzad);
   
    waitForNewIteration (); % wait for new iteration
end

%obliczenie b??du
E=sum((e).^2);
end