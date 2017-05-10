function [x, fval] = dmc_rozm_optim(reg_no)

options = gaoptimset('UseParallel',true);
if reg_no == 2
    lb = [0.1 0.1 ];
    ub = [500 500];
    [x,fval] = ga(@(x)(dmc_rozm(25,1,[x(1),x(2)],2,x(3),x(4),false)),4,[],[],[],[],lb,ub,[],[]);
elseif reg_no == 3
    lb = [0.1 0.1 0.1];
    ub = [500 500 500];
    [x,fval] = ga(@(x)(dmc_rozm(25,1,[x(1) x(2) x(3)],3, 33.4942, [-0.6109 0.7654],false)),3,[],[],[],[],lb,ub,[],options);
elseif reg_no == 4
    lb = [0.1 0.1 0.1 0.1];
    ub = [ 150 150 150 150];
    [x,fval] = ga(@(x)(dmc_rozm(25,1,[x(1) x(2) x(3) x(4)],4,x(5),[x(6) x(7) x(8)],false)),8,[],[],[],[],lb,ub,[],options);
elseif reg_no == 5
    options.InitialPopulationMatrix = [50 50 10 10 10 10];
    lb = [0.1 0.1 0.1 0.1 0.1];
    ub = [150 150 150 150 150];
    [x,fval] = ga(@(x)(dmc_rozm(25,1,[x(1),x(2),x(3),x(4),x(5)],5,x(6),[x(7) x(8) x(9) x(10)],false)),10,[],[],[],[],lb,ub,[],options);
end