function [y, u] = skok(dU)
    Upp = 0;
    Ypp = 0;
    Umin = -1;
    Umax = 1;

    kstart = 7;
    kend = 200;    
    u = Upp*ones(kend, 1);
    y = Ypp*ones(kend, 1);
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