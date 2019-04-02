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
	cout << "HOLA" << endl;
	FILE * pFile;
	int n, m;
	float* r, *g, *b; 


	pFile = fopen ("img_2.txt","r");
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

	for (int i = 0; i < (n*m); ++i) {
		cout << r[i] << endl;
		//cout << *g << "|" << 1-*g << endl;
		//cout << *b << "|" << 1-*b << endl;
		CambiarColores(&r[i], &g[i], &b[i]);
	}

	FILE * pSalida;
	pSalida = fopen ("img_salida.txt","w");
	fprintf(pSalida, "%d %d\n", m, n);
	for (int i = 0; i < n*m; ++i) {
		fprintf(pSalida, "%f ", r[i]);
	}
	fprintf(pSalida, "\n");
	for (int i = 0; i < n*m; ++i) {
		fprintf(pSalida, "%f ", g[i]);
	}
	fprintf(pSalida, "\n");
	for (int i = 0; i < n*m; ++i) {
		fprintf(pSalida, "%f ", b[i]);
	}

	//cin.get();
	return 0;
}