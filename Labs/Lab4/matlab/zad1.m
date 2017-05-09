
%Badanie punktu pracy

 addpath ('F:\SerialCommunication'); % add a path
 initSerialControl COM3 % initialise com port

Upp1=27;
n=400;
Y = zeros(1,n);
figure
sendControls([1],[50]);
sendNonlinearControls(Upp1);

for k=1:n
 %% obtaining measurements
 Y(:,k) = readMeasurements ([1]) ; % read measurements

 %% processing of the measurements
 disp(k);
 disp ( Y(:,k) ); % process measurements

 %% sending new values of control signals
 


 plot(Y(1,:))

 drawnow
 waitForNewIteration (); % wait for new iteration
 end