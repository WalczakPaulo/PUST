function [] = draw_5sigm(alfa,c)
close all
    y = -0.15:0.01:4.28;
    for k= 1:length(y)
        mi1(k)=1-1/(1+exp(-alfa*(y(k)-c(1))));%-0.05
        mi2(k)=1/(1+exp(-alfa*(y(k)-c(1))))-1/(1+exp(-alfa*(y(k)-c(2))));%1.4
        mi3(k)=1/(1+exp(-alfa*(y(k)-c(2))))-1/(1+exp(-alfa*(y(k)-c(3))));
        mi4(k)=1/(1+exp(-alfa*(y(k)-c(3))))-1/(1+exp(-alfa*(y(k)-c(4))));
        mi5(k)=1/(1+exp(-alfa*(y(k)-c(4))));
    end
    plot(y, mi1)
    figure
    plot(y, mi2)
    figure
    plot(y, mi3)
    figure
    plot(y, mi4)
    figure
    plot(y, mi5)
    write_to_file('5_reg_sigm_1',y,mi1)
    write_to_file('5_reg_sigm_2',y,mi2)
    write_to_file('5_reg_sigm_3',y,mi3)
    write_to_file('5_reg_sigm_4',y,mi4)
    write_to_file('5_reg_sigm_5',y,mi5)
end