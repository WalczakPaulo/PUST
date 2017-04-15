function [y, u] = skok(dU)
    Upp = 0;
    Tp = 0.5;
    Umin = -1;
    Umax = 1;

    kstart = 7;
    kend = 100;    
    u = Upp*ones(kend, 1);
    y = zeros(kend, 1);
    u(kstart:kend) = u(kstart:kend) + dU;
    for k = kstart:kend
        if u(k) > Umax
            u(k) = Umax;
        elseif u(k) < Umin
            u(k) = Umin;
        end
        y(k) = symulacja_obiektu5y(u(k-5), u(k-6), y(k-1), y(k-2));
    end
end