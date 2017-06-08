%%Socket Communication demo script

%t = tcpip('192.168.127.250',4000, 'NetworkRole', 'client');

delete(instrfindall)

pause(2);

%%fclose(t);
%%delete(t);
%%clear t;

close all;
clear all;
 
 
%%t = tcpip('192.168.0.150',4000);
 
t = tcpip('192.168.127.250',4000, 'NetworkRole', 'client');

t.OutputBufferSize = 3000;
t.InputBufferSize = 3000;
 
fopen(t);
fprintf('Fopen zadzialal');
iterator = 1;
data = zeros(2,2);
U = zeros(2,2);
Yzad = zeros(2,2);
figY = figure;
figU = figure;
while(1)   
    if (t.BytesAvailable ~= 0)
        temp = fscanf(t);
        temp
        eval(temp);
        data(1,iterator) = Y1/100;
        data(2,iterator) = Y2/100;
        U(1,iterator) = U1/10;
        U(2,iterator) = U2/10;
        Yzad(1, iterator) = Yzad1;
        Yzad(2, iterator) = Yzad2;
        fprintf('Fscanf zadzialal');
        iterator=iterator + 1;
        figure(figY);
        plot(1:length(data(1,:)), data(1,:));
        hold on;
        grid on;
        plot(1:length(data(2,:)), data(2,:));
        plot(1:length(Yzad(1,:)), Yzad(1,:));
        plot(1:length(Yzad(2,:)), Yzad(2,:));
        hold off;
        drawnow
        figure(figU);
        plot(1:length(U(1,:)), U(1,:));
        hold on;
        grid on;
        plot(1:length(U(2,:)), U(2,:));
        hold off;
        drawnow
    end
    pause(0.05);
end

fclose(t);
delete(t);
clear t;


%fprintf(t,'Init comm');
 
 
%fclose(t);



%fopen(t); 

iter = 1;
%data = fread(t,2);
read_done = 0;
while(read_done == 0)
    pause(1);
    fprintf(t,'Waiting for response from server %d\n',iter);
    iter = iter + 1;
%     if (t.BytesAvailable ~= 0)
%         data = fread(t,t.BytesAvailable);
%         read_done = 1;
%     end
    temp = fscanf(t);
    temp

end
data

temp = fscanf(t);

temp

fclose(t);
delete(t);
clear t;