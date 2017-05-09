function [] = draw_sigm(alfa,c)
close all
    y = -0.15:0.01:4.28;
    for k= 1:length(y)
        mi1(k) = 1/(1+exp(-alfa*(y(k)-c)));
        mi2(k) = 1 - 1/(1+exp(-alfa*(y(k)-c)));
    end
    plot(y, mi1)
    figure
    plot(y, mi2)

    write_to_file('2_reg_sigm_1',y,mi1)
    write_to_file('2_reg_sigm_2',y,mi2)

end