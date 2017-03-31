addpath('F:\SerialCommunication'); % add a path to the functions
initSerialControl COM4 % initialise com port
Upp = 27;
skok = 30;
iter = 1;
dU = 20;
sz = zeros(500,1);
while(iter < 500)
        %% obtaining measurements
        measurements = readMeasurements(1:7); % read measurements from 1 to 7
        sz(iter) = measurements(1);
        disp(measurements); % process measurements
        sendControlsToG1AndDisturbance(Upp + dU,0);
        iter = iter + 1;
        plot(sz);
        drawnow; 
        waitForNewIteration(); % wait for new batch of measurements to be ready
end

sz = (sz - sz(1))/dU;