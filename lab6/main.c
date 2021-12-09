#include "tools.h"

int main()
{
    FILE* Vout = fopen("Vn4.dat", "w");
    solve(4, 4, 10, -10, 10, -10, 1, 1, qIs0, Vout, true);
    fclose(Vout);

    FILE* Vn50 = fopen("Vn50.dat", "w");
    solve(50, 50, 10, -10, 10, -10, 1, 1, qIs0, Vn50, false);
    fclose(Vn50);

    FILE* Vn100 = fopen("Vn100.dat", "w");
    solve(100, 100, 10, -10, 10, -10, 1, 1, qIs0, Vn100, false);
    fclose(Vn100);

    FILE* Vn200 = fopen("Vn200.dat", "w");
    solve(200, 200, 10, -10, 10, -10, 1, 1, qIs0, Vn200, false);
    fclose(Vn200);

    FILE* Ve1 = fopen("Ve11.dat", "w");
    solve(100, 100, 0, 0., 0, 0, 1, 1, q1q2, Ve1, false);
    fclose(Ve1);

    FILE* Ve12 = fopen("Ve12.dat", "w");
    solve(100, 100, 0, 0, 0, 0, 1, 2, q1q2, Ve12, false);
    fclose(Ve12);

    FILE* Ve10 = fopen("Ve10.dat", "w");
    solve(100, 100, 0, 0, 0, 0, 1, 10, q1q2, Ve10, false);
    fclose(Ve10);

    return 0;
}