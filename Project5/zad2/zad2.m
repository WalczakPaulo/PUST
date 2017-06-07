clear all
n=210;
y=zeros(3,n);
for i=1:4 %sterowanka
    u=zeros(4,n);
    u(i,5:n)=1;
    for k=5:n
        [y(1,k),y(2,k),y(3,k)]=symulacja_obiektu5(u(1,k-1),u(1,k-2),u(1,k-3),u(1,k-4),...
        u(2,k-1),u(2,k-2),u(2,k-3),u(2,k-4),...
        u(3,k-1),u(3,k-2),u(3,k-3),u(3,k-4),...
        u(4,k-1),u(4,k-2),u(4,k-3),u(4,k-4),...
        y(1,k-1),y(1,k-2),y(1,k-3),y(1,k-4),...
        y(2,k-1),y(2,k-2),y(2,k-3),y(2,k-4),...
        y(3,k-1),y(3,k-2),y(3,k-3),y(3,k-4));
    end
 
    
    csvwrite(sprintf('Y1U%d.csv',i), y(1, 6: n));
    csvwrite(sprintf('Y2U%d.csv',i), y(2, 6: n));
    csvwrite(sprintf('Y3U%d.csv',i), y(3, 6: n));
 
    subplot(2,2,i)
    hold on
    title(sprintf('Reakcja na skok U%d', i)); 
    legend('Y1','Y2','Y3')
    xlabel('k')
    ylabel('Y')
    plot(y(1,6:n),'r')
    plot(y(2,6:n),'b')
    plot(y(3,6:n),'g')
    

end