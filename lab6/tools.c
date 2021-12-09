#include "tools.h"

double q1(double delta, int i, int j, int nx, int ny){
    double x = i * delta; double y = j * delta;
    double xmax = nx * delta; double ymax = ny * delta;
    return exp( -(pow(x - 0.25*xmax, 2) / pow(xmax/10.0,2))- (pow(y - 0.5*ymax, 2) / pow(xmax/10.0,2)) );
}

double q2(double delta, int i, int j, int nx, int ny){
    double x = i * delta; double y = j * delta;
    double xmax = nx * delta; double ymax = ny * delta;
    return -1 * exp( -(pow(x - 0.75*xmax, 2)/pow(xmax/10.0,2))- (pow(y - 0.5*ymax, 2)/pow(xmax/10.0,2)) );
}

double q1q2(double delta, int i, int j, int nx, int ny){
    return  -1*( q1(delta, i, j, nx, ny) + q2(delta, i, j, nx, ny) );
}

double qIs0(double delta, int i, int j, int nx, int ny){
    return 0;
}

void setEps(int N, int nx, int e1, int e2, double* epsArr){
    int i = 0;
    int j = 0;
    for(int l = 0; l < N; l++){
        j = floor(l/(nx+1));
        i = l-j*(nx+1);
        if (i <= nx / 2) epsArr[l] = e1;
        else epsArr[l] = e2;
    }
}

void solve( int nx, int ny, double v1, double v2, double v3, double v4, int e1, 
        int e2, double (*q)(double, int, int, int, int), FILE* Vout, bool saveThis){
    double delta = 0.1;
    int N = (nx + 1) * (ny + 1);
    int i = 0;
    int j = 0;

    double* a = calloc(5*N, sizeof(double));
    int* ia =  calloc(N, sizeof(int));
    int* ja = calloc(5*N, sizeof(int));
    double* b = calloc(N, sizeof(double));
    double* V = calloc(N, sizeof(double));

    memset(ia, -1, N * sizeof(int));

    double* epsArr = calloc(N, sizeof(double));
    setEps(N, nx, e1, e2, epsArr);

    int k = -1;

    for(int l = 0; l < N; l++){
        int brzeg = 0;
        double vb = 0.0;
        j = floor(l/(nx+1));
        i = l-j*(nx+1);

        if(i == 0){ brzeg = 1; vb = v1; }
        if(j == ny){ brzeg = 1; vb = v2; }
        if(i == nx){ brzeg = 1; vb = v3;}
        if(j == 0){ brzeg = 1; vb = v4; }

        b[l] = (*q)(delta, i, j, nx ,ny);

        if(brzeg == 1) b[l] =  vb;

        ia[l] = -1;

        if(l - nx - 1 >= 0 && brzeg == 0){
            k++;
            if(ia[l] < 0) ia[l] = k;
            a[k] = epsArr[l] / pow(delta,2);
            ja[k] = l - nx - 1;
        }

        if(l-1 >= 0 && brzeg == 0){
            k++;
            if(ia[l]<0) ia[l] = k;
            a[k]= epsArr[l] / pow(delta,2);
            ja[k] = l - 1;
        }

        k++;
        if(ia[l] < 0) ia[l] = k;
        if(brzeg == 0) a[k] = -(2*epsArr[l] + epsArr[l+1]+ epsArr[l+nx+1]) / pow(delta,2);
        else a[k] = 1;
        ja[k] = l;

        if(l < N && brzeg == 0){
            k++;
            a[k] = epsArr[l+1] / pow(delta,2);
            ja[k] = l + 1;
        }


        if(l < N -nx -1 && brzeg ==0){
            k++;
            a[k] = epsArr[l+nx+1]/pow(delta,2);
            ja[k] = l + nx +1;
        }
    }

    if( saveThis ){
        FILE* Aout = fopen("macA.dat", "w");
        FILE* Bout = fopen("vecB.dat", "w");
        for(int l = 0; l < 5*N; l++){
            j = floor(l/(nx+1));
            i = l-j*(nx+1);
            if(fabs(a[l]) > 1e-9) fprintf(Aout, "%d\t%d\t%d\t%g\n", l, i, j, a[l]);
            if(fabs(b[l]) > 1e-9) fprintf(Bout, "%d\t%d\t%d\t%g\n", l, i, j, b[l]);
        }
        fclose(Aout);
        fclose(Bout);
    }

    int nz_num = k + 1;
    ia[N] = nz_num;

    pmgmres_ilu_cr(N, nz_num, ia, ja, a, V, b, 500, 500, 1e-8, 1e-8);

    for(int l = 0; l < N; l++){
        fprintf(Vout, "%g\t", V[l]);
        if((l+1) % (nx+1) == 0) fprintf(Vout, "\n");
    }

    free(ia);
    free(ja);
    free(V);
    free(b);
    free(a);
    free(epsArr);
}
