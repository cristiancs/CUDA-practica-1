#include<iostream>
#include <fstream>
#include <string>
#include <stdio.h>
#include <stdlib.h>
using namespace std;


void CambiarColores(float* r, float* g, float* b) {
	//cout << *r << "|" << 1-*r << endl;
	*r = 1 - *r;
	*g = 1 - *g;
	*b = 1 - *b;
}


int main(int argc, char const *argv[]) {
	FILE * pFile;
	int n, m;
	float* r, *g, *b; 


	pFile = fopen ("img.txt","r");
	fscanf(pFile, "%d %d", &m, &n);

	r = new float[n*m];
	g = new float[n*m];
	b = new float[n*m];

	for (int i = 0; i < n*m; ++i) {
		fscanf (pFile, "%f", &r[i]);
	}

	for (int i = 0; i < n*m; ++i) {
		fscanf (pFile, "%f", &g[i]);
	}

	for (int i = 0; i < n*m; ++i) {
		fscanf (pFile, "%f", &b[i]);
	}



	fclose (pFile);

	clock_t t1, t2;
	double ms;
	

	t1 = clock();
    
    for (int i = 0; i < (n*m); ++i) {
		CambiarColores(&r[i], &g[i], &b[i]);
	}


    t2 = clock();
    ms = 1000.0 * (double)(t2 - t1) / CLOCKS_PER_SEC;
    cout << "Tiempo CPU: " << ms << " [ms]" << endl;

	FILE * pSalida;
	pSalida = fopen ("img_salida.txt","w");
	fprintf(pSalida, "%d %d\n", m, n);
	for (int i = 0; i < n*m; ++i) {
		if(i == n*m - 1) {
			fprintf(pSalida, "%f", r[i]);
		} else {
			fprintf(pSalida, "%f ", r[i]);
		}
		
	}
	fprintf(pSalida, "\n");
	for (int i = 0; i < n*m; ++i) {
		if(i == n*m - 1) {
			fprintf(pSalida, "%f", g[i]);
		} else {
			fprintf(pSalida, "%f ", g[i]);
		}
	}
	fprintf(pSalida, "\n");
	for (int i = 0; i < n*m; ++i) {
		if(i == n*m - 1) {
			fprintf(pSalida, "%f", b[i]);
		} else {
			fprintf(pSalida, "%f ", b[i]);
		}
	}
	delete r;
	delete g;
	delete b;

	//cin.get();
	return 0;
}