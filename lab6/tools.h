#pragma once
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdbool.h>
#include "mgmres.h"

double q1(double delta, int i, int j, int nx, int ny);

double q2(double delta, int i, int j, int nx, int ny);

double q1q2(double delta, int i, int j, int nx, int ny);

double qIs0(double delta, int i, int j, int nx, int ny);

void setEps(int N, int nx, int e1, int e2, double* epsArr);

void solve(int nx, int ny, double v1, double v2, double v3, double v4, int e1,
        int e2, double (*g)(double, int, int, int, int), FILE* Vout, bool saveThis);
