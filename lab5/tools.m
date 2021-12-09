classdef tools
    
    methods (Static)
        
        function createMap(k,V)
            figure();
            V2 = V(1:k:end,1:k:end);
            mapa = pcolor(V2');
            set(mapa, 'EdgeColor', 'none');
            colormap;
            colorbar;
            legend(sprintf('k = %d',k));
        end
        
        function [sSave, itSave, V] = relaksacjaWielosiatkowa()
            delta = 0.2; nx = 128; ny = 128; TOL = 1e-8;
            xmax = delta * nx;
            ymax = delta * ny;
            
            oldS = 1;
            S(1) = 0;
            it(1) = 0;
            V = zeros(nx+1,ny+1);
            sSave = [];
            itSave = [];
            
            %poczatkowe warunki brzgowe
            for i = 1:ny+1
                V(1,i) = sin(pi * (i * delta / ymax) );
                V(nx+1,i) = sin(pi * (i * delta / ymax) );
            end
            for i = 1:nx+1
                V(i,1) = sin(2*pi * (i * delta / xmax) );
                V(i,ny+1) = -sin(2*pi * (i * delta / xmax) );
            end

            for k = [16,8,4,2,1]
                n = 0;
                while(true)
                    for i = k+1:k:nx+1-k
                        for j = k+1:k:ny+1-k
                            V(i,j) = 0.25 * ( V(i+k,j) + V(i-k,j) + V(i,j+k) + V(i,j-k) );
                        end
                    end

                    newS = 0;
                    for i = 1:k:nx+1-k
                        for j = 1:k:ny+1-k
                             newS = newS + 0.5*(k*delta)^2 * ( ( (V(i+k,j)-V(i,j))/(2*k*delta) + (V(i+k,j+k)-V(i,j+k))/(2*k*delta) )^2 + ((V(i,j+k)-V(i,j))/(2*k*delta) + (V(i+k,j+k)-V(i+k,j))/(2*k*delta) )^2 );
                        end
                    end
                    n = n + 1;
                    S(end) = newS;
                    sSave(k,n) = newS;
                    it(end+1) = it(end) + 1;
                    itSave(k,n) = it(end);
                    if abs((newS-oldS)/(oldS)) < TOL
                        break;
                    end
                    oldS = S(end);
                    S(end+1) = 0;
                   
                end
                
                tools.createMap(k,V);                
                
                %zageszczanie siatki
                if k ~= 1 
                    for i = 1:k:nx+1-k
                        for j = 1:k:ny+1-k
                            V(i+k/2,j+k/2) = 0.25 * ( V(i,j) + V(i+k,j) + V(i,j+k) + V(i+k,j+k) );
                            V(i+k,j+k/2) = 0.5 * ( V(i+k,j) + V(i+k,j+k) );
                            V(i+k/2,j+k) = 0.5 * ( V(i,j+k) + V(i+k,j+k) );
                            V(i+k/2,j) = 0.5 * ( V(i,j) + V(i+k,j) );
                            V(i,j+k/2) = 0.5 * ( V(i,j) + V(i,j+k) );
                        end
                    end
                end
                    
                %ponownie warunki brzgowe
                for i = 1:ny+1
                    V(1,i) = sin(pi * (i * delta / ymax) );
                    V(nx+1,i) = sin(pi * (i * delta / ymax) );
                end
                for i = 1:nx+1
                    V(i,1) = sin(2*pi * (i * delta / xmax) );
                    V(i,ny+1) = -sin(2*pi * (i * delta / xmax) );
                end

            end
        end
        
        
    end
end

