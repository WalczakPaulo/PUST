function[Y,U] = MinimalWorkingExample ()
 addpath ('F:\SerialCommunication'); % add a path
 initSerialControl COM14 % initialise com port

Upp=36;
Ypp=36.5;
dU=0;
kk=450;
U = Upp*ones(kk,1);
U(10:kk)=U(10:kk)+dU;
Upp = 60;
% Y = zeros(kk,1);
sendControls ([ 1, 2, 3, 4, 5, 6],[ 50, 0, 0, 0, Upp, 0]) ;
 for k=1:kk
 %% obtaining measurements
 Y(k) = readMeasurements (1) ; % read measurements

 %% processing of the measurements
 disp([k,Y(k)]);

 

 %% sending new values of control signals
 

 %% synchronising with the control process
 waitForNewIteration (); % wait for new iteration
 plot(Y)
 drawnow
 end
%toPlotForLatex('skokU_15',1:kk,U')
%toPlotForLatex('skokY_15',1:kk,Y')
end