classdef tools
    methods (Static)
        %zad1
        function u = Picard(N)
            B = 0.001;
            gamma = 0.1;
            tmax = 100;
            dt = 0.1;
            u(1) = 1;
            TOL = 10^-6;
            alpha = B*N - gamma;
            
            n = 1;
            for time = (0+dt):dt:tmax 
                mi = 0;
                u(n + 1) = u(n); 
                uOlder = u(n+1);
                while (mi <= 20) && ((u(n+1) - uOlder) < TOL)
                    uOlder = u(n+1);
                    u(n+1) = u(n) + dt*((alpha*u(n) - B*(u(n)^2)) + (alpha*u(n+1) - B*(u(n+1)^2)))/2;
                    mi = mi + 1;
                end
                n = n + 1;
            end
        end
        
        %zad2 iteracja Newtona
        function u = Newton(N)
            B = 0.001;
            gamma = 0.1;
            tmax = 100;
            dt = 0.1;
            u(1) = 1;
            TOL = 10^-6;
            alpha = B*N - gamma;
            
            n = 1;
            for time = (0+dt):dt:tmax 
                mi = 0;
                u(n + 1) = u(n); 
                uOlder = u(n+1);
                while (mi <= 20) && ((u(n+1) - uOlder) < TOL)
                    uOlder = u(n+1);
                    u(n+1) = uOlder - (uOlder - u(n) - dt*((alpha*u(n) - B*(u(n)^2)) + (alpha*uOlder - B*(uOlder^2)))/2)/(1 - dt*(alpha -2*B*uOlder));
                    mi = mi + 1;
                end
                n = n + 1;
            end
        end
        
        %zad3 RK2
        function u = RK2(N)
            B = 0.001;
            gamma = 0.1;
            tmax = 100;
            dt = 0.1;
            u(1) = 1;
            TOL = 10^-6;
            alpha = B*N - gamma;
            c1 = 1/2 - sqrt(3)/6;
            c2 = 1/2 + sqrt(3)/6;
            b1 = 1/2;
            b2 = 1/2;
            a = [ 1/4, 1/4 - sqrt(3)/6; 1/4 + sqrt(3)/6, 1/4];
            f = @(p_t, p_u) (B*N-gamma)*p_u - B*(p_u^2); 
            
            n = 1;
            for time = (0+dt):dt:tmax
                mi = 0;
                U1 = u(n);
                U2 = u(n);
                dU1 = 0;
                dU2 = 0;
                F1 = 0;
                F2 = 0;
                %drugi warunek ??
                while mi <= 20
                    F1 = U1 - u(n) - dt*(a(1,1) * (alpha*U1 - B*(U1^2)) + a(1,2)*(alpha*U2-B*(U2^2)));
                    F2 = U2 - u(n) - dt*(a(1,1) * (alpha*U1 - B*(U1^2)) + a(1,2)*(alpha*U2-B*(U2^2)));
                    m11 = 1 - dt*a(1,1)*(alpha-2*B*U1);
                    m12 = -dt*a(1,2)*(alpha-2*B*U2);
                    m21 = -dt*a(2,1)*(alpha-2*B*U1);
                    m22 = 1 - dt*a(2,2)*(alpha-2*B*U2);
                    dU1 = (F2*m12 - F1*m22)/(m11*m22 - m12*m21);
                    dU2 = (F1*m21 - F2*m11)/(m11*m22 - m12*m21);
                    
                    U1 = U1 + dU1;
                    U2 = U2 + dU2;
                    mi = mi + 1;
                end
                u(n+1) = u(n) + dt*(b1*f(time + c1*dt, U1) + b2*f(time + c2*dt, U2));
                n = n + 1;
            end
        end
    end
end

