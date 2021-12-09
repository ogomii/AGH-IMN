classdef tools

    methods (Static)
        
        function [xn1, vn1] = metodaTrapezow(xn, vn, dt, alpha)
            xn1 = xn;
            vn1 = vn;
            delta = 1e-10;
            
            g   = @(alpha, x, v) (alpha*(1-x^2)*v-x);
            while(true)
                a11 = 1;
                a12 = - dt/2;
                a21 = - (dt/2) * (-2 * alpha * xn1 * vn1 - 1);
                a22 = 1 - (dt/2) * alpha * (1 - xn1^2);
               
                F   = xn1 - xn - (dt/2)*(vn + vn1);
                G   = vn1 - vn - (dt/2)*( g(alpha,xn,vn) + g(alpha,xn1,vn1) );
               
                dx  = (-F * a22 - (-G) * a12) / (a11 * a22 - a12 * a21);
                dv  = (a11 * (-G) - a21 * (-F)) / (a11 * a22 - a12 * a21);
               
                xn1 = xn1 + dx;
                vn1 = vn1 + dv;
               
                if( (abs(dx) >= delta) && (abs(dv) >= delta) )
                    break;
                end               
            end
            
        end
        
        function [xn1, vn1] = RK2(xn, vn, dt, alpha)
            k1x = vn;
            k1v = alpha * (1 - xn^2) * vn - xn;
            
            k2x = vn + dt * k1v;
            k2v = alpha * ( 1 - (xn + dt * k1x)^2 ) * (vn + dt * k1v) - (xn + dt * k1x);
            
            xn1 = xn + dt * (k1x + k2x)/2;
            vn1 = vn + dt * (k1v + k2v)/2;
        end
        
        function [Sx, Sv, Sdt ,St] = timeControl(TOL, method)
            x0  = 0.01;
            v0  = 0;
            dt0 = 1;
            S   = 0.75;
            p   = 2;
            tmax    = 40;
            alpha   = 5;
            
            t   = 0;
            dt  = dt0;
            xn  = x0;
            vn  = v0;
            
            Sx = []; Sv = []; Sdt =[]; St = [];
            while (true)
                [xn12, vn12] = method(xn, vn, dt, alpha);
                [xn22, vn22] = method(xn12, vn12, dt, alpha);
                
                [xn21, vn21] = method(xn, vn, 2.0*dt, alpha);
                
                Ex = (xn22 - xn21) / (2^p - 1);
                Ev = (vn22 - vn21) / (2^p - 1);
                
                maxEE = max(abs(Ex), abs(Ev));
                if (maxEE < TOL)
                   t  = t + 2.0 * dt;
                   xn = xn22;
                   vn = vn22;
                   
                   Sx(end + 1) = xn; Sv(end + 1) = vn; Sdt(end + 1) = dt; St(end + 1) = t;
                end
                
                dt = dt *( ( (S*TOL)/ maxEE ).^(1/(p+1)) );
                if(t >= tmax)
                    break;
                end
            end
        end
        
    end
end

