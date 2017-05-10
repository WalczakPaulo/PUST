function [error]=dmc_rozm(N, Nu, lambda, reg_no, alfa, c, draw)

close all

D=50;

Upp = 0;
Ypp = 0;

Umin = -1;
Umax = 1;

error = 0;

kstart = 7;
kend = 1200;

Yzad = zeros(N,1);
Y0 = zeros(N,1);
Yk = zeros(N,1);

M=zeros(N,Nu);
MP=zeros(N,D-1);
I=eye(Nu);
ku=zeros(reg_no,D-1);
ke=zeros(1,reg_no);

if reg_no == 2
    s(:,1) = step_resp(read_file('zad2_y_5'),-0.2);
%     s(:,1) = step_resp(read_file('zad2_y_10'),1);
    s(:,2) = step_resp(read_file('zad2_y_9'),0.8);
elseif reg_no == 3
    s(:,1) = step_resp(read_file('zad2_y_4'),-0.4);
    s(:,2) = step_resp(read_file('zad2_y_7'),0.4);
    s(:,3) = step_resp(read_file('zad2_y_9'),0.8);
elseif reg_no == 4
    s(:,1) = step_resp(read_file('zad2_y_4'),-0.4);
    s(:,2) = step_resp(read_file('zad2_y_6'),0.2);
    s(:,3) = step_resp(read_file('zad2_y_7'),0.4);
    s(:,4) = step_resp(read_file('zad2_y_9'),0.8);
elseif reg_no == 5
    s(:,1) = step_resp(read_file('zad2_y_2'),-0.8);
    s(:,2) = step_resp(read_file('zad2_y_5'),-0.2);
    s(:,3) = step_resp(read_file('zad2_y_6'),0.2);
    s(:,4) = step_resp(read_file('zad2_y_7'),0.4);
    s(:,5) = step_resp(read_file('zad2_y_9'),0.8);
end

for m = 1:reg_no
    for i=1:N
            for j=1:Nu
                if (i>=j)
                    M(i,j)=s(i-j+1,m);
                end;
            end;
    end;

    for i=1:N
        for j=1:D-1
            if i+j<=D
                MP(i,j)=s(i+j,m)-s(j,m);
            else
                MP(i,j)=s(D,m)-s(j,m);
            end;
        end;
    end;

    K=((M'*M+lambda(m)*I)^-1)*M';
    ku(m,:)=K(1,:)*MP;
    ke(m)=sum(K(1,:));
end

% Obliczanie parametrów regulatora


U(1:kend)=Upp;
Y(1:kend)=Ypp;

e=zeros(1,kend);
yzad(1:250) = 1;
yzad(251:500) = 3;
yzad(501:750) = 2;
yzad(751:kend) = -0.07;
% Yzad(startk:1410)=Ypp+5;

deltaup=zeros(1,D-1);

Un=zeros(1,reg_no);
mi=Un;

for k=7:kend
    %symulacja obiektu
    
    %uchyb regulacji
    e(k)=yzad(k-1) - Y(k-1);
    
    for m=1:reg_no
        % Prawo regulacji
        Un(m)=ke(m)*e(k)-ku(m,:)*deltaup';
        %Un(m)=U(k-1)+deltauk;
    end
    if reg_no==2
        mi(1)=1-1/(1+exp(-alfa*(Y(k-1)-c(1))));%0.5
        mi(2)=1/(1+exp(-alfa*(Y(k-1)-c(1))));
    elseif reg_no==3
        mi(1)=1-1/(1+exp(-alfa*(Y(k-1)-c(1))));%-0.05
        mi(2)=1/(1+exp(-alfa*(Y(k-1)-c(1))))-1/(1+exp(-alfa*(Y(k-1)-c(2))));%1.4
        mi(3)=1/(1+exp(-alfa*(Y(k-1)-c(2))));
    elseif reg_no==4 %200 10 2 0.1
        %p6DMC(100,100,[3 4 5 30],4,[200 10 2 0.1],[-0.05 0.8 1.4],false)
        mi(1)=1-1/(1+exp(-alfa*(Y(k-1)-c(1))));%-0.05
        mi(2)=1/(1+exp(-alfa*(Y(k-1)-c(1))))-1/(1+exp(-alfa*(Y(k-1)-c(2))));%0.5
        mi(3)=1/(1+exp(-alfa*(Y(k-1)-c(2))))-1/(1+exp(-alfa*(Y(k-1)-c(3))));%1.4
        mi(4)=1/(1+exp(-alfa*(Y(k-1)-c(3))));
    elseif reg_no==5 %200 40 40 30 10
        mi(1)=1-1/(1+exp(-alfa*(Y(k-1)-c(1))));%-0.05
        mi(2)=1/(1+exp(-alfa*(Y(k-1)-c(1))))-1/(1+exp(-alfa*(Y(k-1)-c(2))));%0.25
        mi(3)=1/(1+exp(-alfa*(Y(k-1)-c(2))))-1/(1+exp(-alfa*(Y(k-1)-c(3))));%0.5
        mi(4)=1/(1+exp(-alfa*(Y(k-1)-c(3))))-1/(1+exp(-alfa*(Y(k-1)-c(4))));%1.4
        mi(5)=1/(1+exp(-alfa*(Y(k-1)-c(4))));
    end
    
    
    deltauk=sum(Un*mi')/sum(mi);
    for i=D-1:-1:2
        deltaup(i)=deltaup(i-1);
    end
    deltaup(1)=deltauk;
    U(k)=U(k-1)+deltauk;
    if U(k)>Umax
        U(k)=Umax;
    elseif U(k)<Umin
        U(k)=Umin;
    end
    Y(k)= symulacja_obiektu5y(U(k-5),U(k-6),Y(k-1),Y(k-2));
    error = error + (yzad(k) - Y(k))^2;
end


if draw
    if reg_no==2
       write_to_file('22_reg_dmc_y', 1:kend, Y)
       write_to_file('22_reg_dmc_u', 1:kend, U)
   elseif reg_no==3
       write_to_file('32_reg_dmc_y', 1:kend, Y)
       write_to_file('32_reg_dmc_u', 1:kend, U)
   elseif reg_no==4
       write_to_file('41_reg_dmc_y', 1:kend, Y)
       write_to_file('41_reg_dmc_u', 1:kend, U)
   elseif reg_no==5
       write_to_file('51_reg_dmc_y', 1:kend, Y)
       write_to_file('51_reg_dmc_u', 1:kend, U)
   end
end
plot(Y)
hold on
plot(yzad)
end