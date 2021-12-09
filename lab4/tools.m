classdef tools
    methods (Static)
        
        function q = rho(i, j)
            delta = 0.1; nx = 150; ny = 100;
            xmax = delta * nx; ymax = delta * ny;
            sigmax = 0.1 * xmax;
            sigmay = 0.1 * ymax;
            x = i * delta;
            y = j * delta;
            q1 = exp( -( (x-0.35*xmax)/sigmax )^2 - ( (y-0.5*ymax)/sigmay )^2 );
            q2 = -1* exp( -( (x-0.65*xmax)/sigmax )^2 - ( (y-0.5*ymax)/sigmay )^2 );
            q = q1 + q2;
        end
            
        function S = getS(nx, ny, Vs, delta)
            S = 0;
            for i = 1:nx
                for j = 1:ny
                    q = tools.rho(i,j);
                    S = S + delta^2 * (0.5 * ((Vs(i+1,j) - Vs(i,j))/delta)^2 + 0.5 * ((Vs(i,j+1) - Vs(i,j))/delta)^2 - q*Vs(i,j) );
                end
             end
        end
        
        function blad = getBlad(nx, ny, Vn, delta, E)
            blad = zeros(nx+1, ny+1);
            for i = 2:nx
                for j = 2:ny
                    q = tools.rho(i,j);
                    blad(i,j) = ( (Vn(i+1,j) - 2 *Vn(i,j) + Vn(i-1,j) ) / (delta^2) + (Vn(i,j+1) - 2 * Vn(i,j) + Vn(i,j-1)) / (delta^2) ) + q/E;
                end
            end
        end
        
        function [S, it, blad, Vs] = relaksacjaGlobalna(wG)
            E = 1; delta = 0.1; nx = 150; ny = 100;
            v1 = 10; v2 = 0;
            
            TOL = 1e-8;
            Vs = zeros(nx + 1,ny + 1);
            Vn = zeros(nx + 1,ny + 1);
            Vs(:,1) = v1; Vs(:,ny+1) = v2;
            Vn(:,1) = v1; Vn(:,ny+1) = v2;
            oldS = 0;
            it(1) = 0;
            S(1) = 0;
            
            while (true)
                for i = 2:nx
                    for j = 2:ny
                        q = tools.rho(i,j);
                        Vn(i,j) = 0.25 * (Vs(i+1,j) + Vs(i-1,j) + Vs(i,j+1) + Vs(i,j-1) + delta^2/E * q );
                    end
                end
                
                Vn(1,:) = Vn(2,:);
                Vn(nx+1,:) = Vn(nx,:);
                Vs = (1-wG) * Vs + wG * Vn;
                
                S(end+1) = tools.getS(nx, ny, Vs, delta);
                it(end+1) = it(end) + 1;
                if abs((S(end) - oldS)/oldS) < TOL
                    break;
                end
                oldS = S(end);
                
                blad = tools.getBlad(nx, ny, Vn, delta, E);
            end
        end
        
        function [S, it] = relaksacjaLokalna(wG)
            E = 1; delta = 0.1; nx = 150; ny = 100;
            v1 = 10; v2 = 0;
            
            TOL = 1e-8;
            V = zeros(nx + 1,ny + 1);
            V(:,1) = v1; V(:,ny+1) = v2;
            oldS = 0;
            it(1) = 0;
            S(1) = 0;
            
            while (true)
                for i = 2:nx
                    for j = 2:ny
                        q = tools.rho(i,j);
                        V(i,j) = (1-wG) * V(i,j) + (wG/4) * ( V(i+1,j) + V(i-1,j) + V(i,j+1) + V(i,j-1) + delta^2/E *q);
                    end
                end
                
                V(1,:) = V(2,:);
                V(nx+1,:) = V(nx,:);
                
                S(end+1) = tools.getS(nx, ny, V, delta);
                it(end+1) = it(end) + 1;
                if abs((S(end) - oldS)/oldS) < TOL
                    break;
                end
                oldS = S(end);
            end
        end
    end
end










