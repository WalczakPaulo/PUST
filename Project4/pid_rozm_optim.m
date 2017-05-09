function [x, fval] = pid_rozm_optim(reg_no)

if reg_no == 2
    lb = [0.1 0.1 1 1 0.1 0.1];
    ub = [0.5 0.5 7 7 6 6];
    [x,fval] = ga(@(x)(pid_rozm([x(1),x(2)],[x(3),x(4)],[x(5),x(6)],2,3,0.3)),6,[],[],[],[],lb,ub,[],[]);
elseif reg_no == 3
    options.InitialPopulationMatrix = [0.2 0.2 0.2 6 6 6 2 2 2];
    lb = [0.1 0.1 0.1 1 1 1 1 1 0];
    ub = [0.5 0.6 0.5 12 12 12 10 10 10];
    [x,fval] = ga(@(x)(pid_rozm([x(1),x(2), x(3)],[x(4),x(5),x(6)],[x(7),x(8),x(9)],3,3,[-0.05,1.3],false)),9,[],[],[],[],lb,ub,[],options);
elseif reg_no == 4
    options.InitialPopulationMatrix = [0.2 0.2 0.2 0.2 6 6 6 6 2 2 2 2];
    lb = [0.01 0.01 0.01 0.01 1 1 1 1 0 0 0 0];
    ub = [0.7 0.7 0.7 15 15 15 15 15 15 15 15 15];
    [x,fval] = ga(@(x)(pid_rozm([x(1),x(2), x(3), x(4)],[x(5),x(6),x(7), x(8)],[x(9),x(10),x(11),x(12)],4,3,[-0.05,0.5,1.3],false)),12,[],[],[],[],lb,ub,[],options);
end