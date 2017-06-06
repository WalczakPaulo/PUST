delete(instrfindall)

pause(2);
close all;
clear all;
t = tcpip('192.168.127.250',4000, 'NetworkRole', 'client');
t.OutputBufferSize = 3000;
t.InputBufferSize = 3000;
fopen(t);
fprintf('Fopen zadzialal');
iterator = 1;
data = zeros(2,2);
figure(1);
while(1)
if (t.BytesAvailable ~= 0)
temp = fscanf(t);
temp
eval(temp);
data(1,iterator) = U;
data(2,iterator) = Y;
fprintf('Fscanf zadzialal');
iterator=iterator + 1;
plot(1:length(data(2,:)), data(2,:));
hold on;
grid on;
plot(1:length(data(1,:)), data(1,:));
hold off;
end
pause(0.05);
end
fclose(t);
delete(t);


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