#include<iostream>
#include <fstream>
#include <string>

using namespace std;
__global__ void kernel(int a) {
	a = 4;
	printf("%d\n", a);
}

int main() {



	int a = 2;
	kernel<<<1, 1>>>(a);
	cudaDeviceSynchronize();
	cout << a << endl;
	cout << "Hola" << endl;
	return 0;
}