#include<iostream>
#include <fstream>
#include <string>
#include <stdio.h>
#include <stdlib.h>
using namespace std;

__global__ void kernel( float* r_gpu,  float* g_gpu,   float* b_gpu, int N) {
	
	int tId = threadIdx.x + blockIdx.x * blockDim.x;
	if(tId < N) {
		r_gpu[tId] = 1 - r_gpu[tId];
		g_gpu[tId] = 1 - g_gpu[tId];
		b_gpu[tId] = 1 - b_gpu[tId];
	}
}



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


	int block_size = 256;
	int grid_size = (int) ceil((float) n*m / block_size);


	float* r_gpu, *g_gpu, *b_gpu;

	cudaMalloc(&r_gpu, sizeof(float) * n * m);
	cudaMalloc(&g_gpu, sizeof(float) * n * m);
	cudaMalloc(&b_gpu, sizeof(float) * n * m);

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

	cudaMemcpy(r_gpu, r, sizeof(float) * n * m, cudaMemcpyHostToDevice);
	cudaMemcpy(g_gpu, g, sizeof(float) * n * m, cudaMemcpyHostToDevice);
	cudaMemcpy(b_gpu, b, sizeof(float) * n * m, cudaMemcpyHostToDevice);

	int tamanio = n * m;

	cudaEvent_t ct1, ct2;
	float dt;
	cudaEventCreate(&ct1);
	cudaEventCreate(&ct2);
	cudaEventRecord(ct1);

	kernel<<<grid_size, block_size>>>(r_gpu, g_gpu, b_gpu, tamanio);

	cudaEventRecord(ct2);
	cudaEventSynchronize(ct2);
	cudaEventElapsedTime(&dt, ct1, ct2);

	cout << "Tiempo GPU: " << dt << " [ms]" << endl; 

	cudaMemcpy(r, r_gpu, sizeof(float) * n * m, cudaMemcpyDeviceToHost);
	cudaMemcpy(g, g_gpu, sizeof(float) * n * m, cudaMemcpyDeviceToHost);
	cudaMemcpy(b, b_gpu, sizeof(float) * n * m, cudaMemcpyDeviceToHost);


	cudaFree(r_gpu);
	cudaFree(g_gpu);
	cudaFree(b_gpu);






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