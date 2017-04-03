function[] = zad2 ()

addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM3 % initialise com port

Upp1= 27;
Upp2 = 32;
kk=350;
Y = zeros(2,kk);
dU1 = 20;
dU2 = 0;


figure
 for k=1:kk
 %% obtaining measurements
 Y(:,k) = readMeasurements ([1,3]) ; % read measurements

 %% processing of the measurements
 disp(k);
 disp ( Y(:,k) ); % process measurements

 %% sending new values of control signals
 sendControls([1,2,5,6],[50,50,Upp1 + dU1, Upp2 + dU2]);

 %% synchronising with the control process
 subplot(211)
 plot(Y(1,:))
 subplot(212)
 plot(Y(2,:))
 drawnow
 toPlotForLatex(sprintf('z2Y1%1.4f%1.4f',dU(1),dU(2)),1:kk,Y(1,:));
 toPlotForLatex(sprintf('z2Y2%1.4f%1.4f',dU(1),dU(2)),1:kk,Y(2,:));
 toPlotForLatex(sprintf('z2U1%1.4f%1.4f',dU(1),dU(2)),1:kk,U(1,:));
 toPlotForLatex(sprintf('z2U2%1.4f%1.4f',dU(1),dU(2)),1:kk,U(2,:));
 waitForNewIteration (); % wait for new iteration
 end
end