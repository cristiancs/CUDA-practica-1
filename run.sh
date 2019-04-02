rm -rf ejercicio
# nvcc -o ejercicio -arch sm_61 main.cu 
nvcc invertir_colores_gpu.cu -o ejercicio -arch sm_61
./ejercicio
#cat img_salida.txt