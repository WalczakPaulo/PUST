
%Badanie punktu pracy

 addpath ('F:\SerialCommunication'); % add a path
 initSerialControl COM17 % initialise com port

Upp1=40;
n=500;
Y = zeros(1,n);
sendControls([1],[50]);
sendNonlinearControls(Upp1);
figure
for k=1:n
 %% obtaining measurements
 Y(:,k) = readMeasurements ([1]) ; % read measurements

 %% processing of the measurements
 disp(k);
 disp ( Y(:,k) ); % process measurements

 %% sending new values of control signals


 %% synchronising with the control process
 plot(Y(1,:))
 drawnow
 waitForNewIteration (); % wait for new iteration
 end
