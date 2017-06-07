clear all;
n=150;
y=zeros(3,n);
u=zeros(4,n);
for k=5:n
        [y(1,k),y(2,k),y(3,k)]=symulacja_obiektu5(u(1,k-1),u(1,k-2),u(1,k-3),u(1,k-4),...
        u(2,k-1),u(2,k-2),u(2,k-3),u(2,k-4),...
        u(3,k-1),u(3,k-2),u(3,k-3),u(3,k-4),...
        u(4,k-1),u(4,k-2),u(4,k-3),u(4,k-4),...
        y(1,k-1),y(1,k-2),y(1,k-3),y(1,k-4),...
        y(2,k-1),y(2,k-2),y(2,k-3),y(2,k-4),...
        y(3,k-1),y(3,k-2),y(3,k-3),y(3,k-4));
end

%plot(y(1,:));
%plot(y(2,:))
%plot(y(3,:))

csvwrite('Y1.csv', y(1,:));
csvwrite('Y2.csv', y(2,:));
csvwrite('Y3.csv', y(3,:));
