rm -rf ejercicio
# nvcc -o ejercicio -arch sm_61 main.cu 
nvcc invertir_colores_gpu.cu -o ejercicio -arch sm_61
g++ invertir_colores_cpu.cpp -o ejercicio-cpu
./ejercicio
./ejercicio-cpu
#cat img_salida.txt