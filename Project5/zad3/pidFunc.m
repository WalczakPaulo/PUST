function [ E ] = pidFunc(K, Ti, Td, whichUs, draw  )


%Parametry

Tp=0.5;
n=1100;

r0=zeros(1,3);
r1=zeros(1,3);
r2=zeros(1,3);

for i=1:3
    r0(i)=K(i)*(1+Tp/(2*Ti(i))+Td(i)/Tp);
    r1(i)=K(i)*(Tp/(2*Ti(i))-2*Td(i)/Tp-1);
    r2(i)=K(i)*Td(i)/Tp;
end

Y=zeros(3,n);

Yzad=zeros(3,n);
Yzad(1,10:200)=2;
Yzad(2,10:200)=2;
Yzad(3,10:200)=2;
Yzad(1,200:500)=-2;
Yzad(2,200:500)=-2;
Yzad(3,200:500)=-2;
Yzad(1,500:800)=1.5;
Yzad(2,500:800)=1.5;
Yzad(3,500:800)=1.5;
Yzad(1,800:n)=0;
Yzad(2,800:n)=0;
Yzad(3,800:n)=0;

u=zeros(4,n);
e1=zeros(1,n);
e2=zeros(2,n);
e3=zeros(3,n);

disp('Calculating process...');

for k=5:n 
    [Y(1,k),Y(2,k),Y(3,k)]=symulacja_obiektu5(u(1,k-1),u(1,k-2),u(1,k-3),u(1,k-4),...
        u(2,k-1),u(2,k-2),u(2,k-3),u(2,k-4),...
        u(3,k-1),u(3,k-2),u(3,k-3),u(3,k-4),...
        u(4,k-1),u(4,k-2),u(4,k-3),u(4,k-4),...
        Y(1,k-1),Y(1,k-2),Y(1,k-3),Y(1,k-4),...
        Y(2,k-1),Y(2,k-2),Y(2,k-3),Y(2,k-4),...
        Y(3,k-1),Y(3,k-2),Y(3,k-3),Y(3,k-4));

    e1(k)=Yzad(1,k)-Y(1,k);
    e2(k)=Yzad(2,k)-Y(2,k);
    e3(k)=Yzad(3,k)-Y(3,k);

    u(whichUs(1),k)=r0(1)*e1(k)+r1(1)*e1(k-1)+r2(1)*e1(k-2)+u(whichUs(1),k-1);
    u(whichUs(2),k)=r0(2)*e2(k)+r1(2)*e2(k-1)+r2(2)*e2(k-2)+u(whichUs(2),k-1);
    u(whichUs(3),k)=r0(3)*e3(k)+r1(3)*e3(k-1)+r2(3)*e3(k-2)+u(whichUs(3),k-1);
end;

disp('Success');
E1=sum(e1(:).^2);
E2=sum(e2(:).^2);
E3=sum(e3(:).^2);
E = E1 + E2 + E3;

csvwrite('yzad.csv', Yzad);
csvwrite('Y1.csv',Y(1,:));
csvwrite('Y2.csv',Y(2,:));
csvwrite('Y3.csv',Y(3,:));
csvwrite('U1.csv',u(1,:));
csvwrite('U2.csv',u(2,:));
csvwrite('U3.csv',u(3,:));
csvwrite('E1.csv',E1);
csvwrite('E2.csv',E2);
csvwrite('E3.csv',E3);


if(draw)
figure;
subplot(131)
plot(u(whichUs(1),:));
title(['K = ', num2str(K(1)), ', Ti = ', num2str(Ti(1)),', Td = ',num2str(Td(1))]);
ylabel(sprintf('U%d',whichUs(1)))
xlabel('iter')
    
subplot(132)
plot(u(whichUs(2),:));
title(['K = ', num2str(K(2)), ', Ti = ', num2str(Ti(2)),', Td = ',num2str(Td(2))]);
ylabel(sprintf('U%d',whichUs(2)))
xlabel('iter')
    
subplot(133)
plot(u(whichUs(3),:));
title(['K = ', num2str(K(3)), ', Ti = ', num2str(Ti(3)),', Td = ',num2str(Td(3))]);
ylabel(sprintf('U%d',whichUs(3)))
xlabel('iter')

    
figure;
subplot(131)
plot(Yzad(1,:),'r--')
title('Yzad1 && Y1');
hold on;
plot(Y(1,:),'b');
legend('Y1','Yzad1','location','best');
ylabel('Y1')
xlabel('iter')
    
subplot(132);
plot(Yzad(2,:),'r--')
title('Yzad2 && Y2');
hold on;
plot(Y(2,:),'g');
legend('Y2','Yzad2','location','best');
ylabel('Y2')  
xlabel('iter')
  
subplot(133)
plot(Yzad(3,:),'r--')
title('Yzad3 && Y3');
hold on;
plot(Y(3,:),'r');
legend('Y3','Yzad3','location','best');
ylabel('Y3')
xlabel('iter')
end


end


