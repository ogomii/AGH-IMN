classdef tools
    methods (Static) 
        %zad1
        function [y,x] = Euler(y0, dt, lambda, tmin, tmax)
            n = 1;
            y(1) = y0;
            x(1) = tmin;
            for h = (tmin + dt):dt:tmax
                y(n+1) = y(n) + dt*lambda*y(n);
                x(n+1) = h;
                n = n + 1;
            end
        end
        
        function [yError] = EulerError(y, x, lambda)
            for i = 1:length(x)
                yError(i) = y(i) - exp(lambda*x(i));
            end
        end
        
        
        %zad2
        function [y,x] = RK2(y0, dt, lambda, tmin, tmax)
            n = 1;
            y(1) = y0;
            x(1) = tmin;
            for h = (tmin + dt):dt:tmax  
                k1 = lambda*y(n);
                k2 = lambda*(y(n) + dt*k1);
                y(n+1) = y(n) + (dt*(k1 + k2))/2.0;
                x(n+1) = h;
                n = n + 1;
            end
        end
        
        %zad3
        function [y,x] = RK4(y0, dt, lambda, tmin, tmax)
            n = 1;
            y(1) = y0;
            x(1) = tmin;
            for h = (tmin + dt):dt:tmax
                k1 = lambda*y(n);
                k2 = lambda*(y(n) + (dt/2.0)*k1);
                k3 = lambda*(y(n) + (dt/2.0)*k2);
                k4 = lambda*(y(n) + dt*k3);
                y(n+1) = y(n) + (dt*(k1 + 2*k2 + 2*k3 + k4))/6.0;
                x(n+1) = h;
                n = n + 1;
            end
        end
        
        %zad4
        function [I,Q,x] = RRZ2(k)
            R = 100;
            L = 0.1;
            C = 0.001;
            w = 1/sqrt(L*C);
            wv = k*w;
            T = 2*pi/w;
            dt = 0.0001;
            tmin = 0;
            tmax = 4*T;
            I(1) = 0;
            Q(1) = 0;
            x(1) = tmin;
            V = @(t) 10*sin(wv*t);
            
            n = 1;
            for h = (tmin + dt):dt:tmax
               k1Q = I(n);
               k1I = V(h)/L - Q(n)/(L*C) - (R*I(n))/L;
               k2Q = I(n) + dt*k1I/2.0;
               k2I = V(h+0.5*dt)/L - (Q(n) + (k1Q*dt)/2.0)/(L*C) - R*(I(n) + (dt*k1I)/2.0)/L;
               k3Q = I(n) + dt*k2I/2.0;
               k3I = V(h+0.5*dt)/L - (Q(n) + (k2Q*dt)/2.0)/(L*C) - R*(I(n) + (dt*k2I)/2.0)/L;
               k4Q = I(n) + dt*k3I;
               k4I = V(h+dt)/L - (Q(n) + (k3Q*dt))/(L*C) - R*(I(n) + (dt*k3I))/L;
               
               Q(n+1) = Q(n) + dt*(k1Q + 2*k2Q + 2*k3Q + k4Q)/6.0;
               I(n+1) = I(n) + dt*(k1I + 2*k2I + 2*k3I + k4I)/6.0;
               x(n+1) = h;
               
               n = n + 1;
            end
        end
    end
end

